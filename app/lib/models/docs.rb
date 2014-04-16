require 'pathname'

class Topic
  def initialize(slug)
    @slug = slug
  end
end

class Docs
  class << self
    def load(categories_slugs)
      @categories = categories_slugs.map { |category_slug|
        category = Category.new(category_slug)
        category.process_topics!
        category.topics
      }
    end

    def categories
      @categories
    end

    def find(category)
      categories.each { |c| return c[:topics] if c[:slug] == category }
      return nil
    end

    def find_topics(category)
      categories.inject([]) { |matches, c|
        matches.concat(c[:topics]) if c[:slug] == category
        matches
      }
    end

  end
end