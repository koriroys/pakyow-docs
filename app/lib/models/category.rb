class Category
  attr_reader :slug
  attr_accessor :topics, :name, :overview

  def initialize(slug)
    @slug = slug
    @topics = []
  end
end
