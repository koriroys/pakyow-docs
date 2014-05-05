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
        pn = Pathname.new(topic_file_path)
        slug = pn.basename(".*").to_s

        if category_heading?(slug)
          category_heading = CategoryHeadingParser.new(pn)
          category.name = category_heading.name
          category.overview = category_heading.overview
        else
          topic_parser = TopicParser.new(pn, category_slug, manifest.order(slug))
          topics << topic_parser.topic
        end
      }.sort_by(&:order)
    end

    def category_heading?(slug)
      slug == "_overview"
    end

    def topics_file_paths(category_slug)
      Dir.glob(File.join("docs", category_slug, '*.md'))
    end
  end
end