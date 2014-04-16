require 'pathname'

class Docs
  class << self
    attr_reader :categories

    def load(categories_slugs)
      @categories = categories_slugs.map { |category_slug|
        category = Category.new(category_slug)
        category.process_topics!
        category
      }
    end

    def find(category_slug)
      categories.find { |category| category.slug == category_slug }
    end
  end
end