require 'pathname'

class Category
  class << self
    attr_reader :all

    def load(slugs)
      @all = slugs.map { |category_slug|
        category = Category.new(category_slug)
        category.parse_topics!
        category
      }
    end

    def find(slug)
      all.find { |category| category.slug == slug }
    end
  end

  attr_reader :slug, :topics, :name, :overview

  def initialize(slug)
    @slug = slug
    @topics = []
  end

  def parse_topics!
    self.topics = topics_file_paths.map { |pn|
      topic_slug = pn.basename(".*").to_s

      if category_heading?(topic_slug)
        category_heading = CategoryHeadingParser.new(pn)
        self.name = category_heading.name
        self.overview = category_heading.overview
        nil
      else
        TopicParser.new(pn, slug, manifest.order(topic_slug)).topic
      end
    }.compact.sort_by(&:order)
  end

  private

  def manifest
    @manifest ||= ManifestParser.new(slug)
  end

  def category_heading?(topic_slug)
    topic_slug == "_overview"
  end

  def topics_file_paths
    topics_file_names.map {|filename| Pathname.new(filename) }
  end

  def topics_file_names
    Dir.glob(File.join("docs", slug, '*.md'))
  end

  attr_writer :name, :overview, :topics
end
