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
    manifest = ManifestParser.new(slug)

    self.topics = topics_file_paths(slug).each.with_object([]) { |topic_file_path, topics|
      pn = Pathname.new(topic_file_path)
      slug = pn.basename(".*").to_s

      if category_heading?(slug)
        category_heading = CategoryHeadingParser.new(pn)
        self.name = category_heading.name
        self.overview = category_heading.overview
      else
        topics << TopicParser.new(pn, slug, manifest.order(slug)).topic
      end
    }.sort_by(&:order)
  end

  private

  def category_heading?(slug)
    slug == "_overview"
  end

  def topics_file_paths(category_slug)
    Dir.glob(File.join("docs", category_slug, '*.md'))
  end

  attr_writer :name, :overview, :topics
end
