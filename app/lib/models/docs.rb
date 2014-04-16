require 'pathname'

class Topic
  def initialize(slug)
    @slug = slug
  end
end

class Docs
  class << self
    def load(categories)
      @results = categories.each.with_object([]) { |category_slug, topics|
        category = Category.new(category_slug)
        category.process_topics!
        topics << category.topics
      }
    end

    def all
      @results
    end

    def find(category)
      all.each { |c| return c[:topics] if c[:slug] == category }
      return nil
    end

    def find_topics(category)
      all.inject([]) { |matches, c|
        matches.concat(c[:topics]) if c[:slug] == category
        matches
      }
    end

  end
end