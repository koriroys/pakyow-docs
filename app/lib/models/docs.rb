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

    def parse_topics(category, category_slug)
      topics_file_paths = Dir.glob(File.join("docs", category_slug, '*.md'))

      topics = topics_file_paths.each.with_object([]) do |topic_file_path, topics|
        topic_parser = TopicParser.new(topic_file_path, category_slug)
        if category_heading?(topic_parser.slug)
          category.set_category_attributes(topic_parser.name, topic_parser.body)
        else
          topics << Topic.new(topic_parser.to_hash)
        end
      end

      topics.sort_by(&:order)
    end

    def category_heading?(slug)
      slug == "_overview"
    end

    def find(category_slug)
      categories.find { |category| category.slug == category_slug }
    end
  end
end