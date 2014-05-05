require 'pathname'

class Docs
  class << self
    attr_reader :categories

    def load(categories_slugs)
      @categories = categories_slugs.map { |category_slug|
        category = Category.new(category_slug)
        category.topics = parse_topics(category, category_slug)
        category
      }
    end

    def find(category_slug)
      categories.find { |category| category.slug == category_slug }
    end

    private

    def parse_topics(category, category_slug)
      manifest = ManifestParser.new(category_slug)

      topics_file_paths(category_slug).each.with_object([]) { |topic_file_path, topics|
        topic_parser = TopicParser.new(topic_file_path, category_slug, manifest)
        if category_heading?(topic_parser.slug)
          category.name = topic_parser.name
          category.overview = topic_parser.body
        else
          topics << topic_parser.topic
        end
      }.sort_by(&:order)
    end

    def topics_file_paths(category_slug)
      Dir.glob(File.join("docs", category_slug, '*.md'))
    end

    def category_heading?(slug)
      slug == "_overview"
    end
  end
end