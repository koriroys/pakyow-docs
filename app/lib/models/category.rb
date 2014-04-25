class Category
  attr_reader :slug, :name, :overview
  attr_accessor :topics

  def initialize(slug)
    @slug = slug
    @topics = []
  end

  def set_category_attributes(name, overview)
    @name = name
    @overview = overview
  end
end

