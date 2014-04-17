class Topic
  attr_reader :name, :body, :slug, :category_slug

  def initialize(name, body, slug, category_slug)
    @name = name
    @body = body
    @slug = slug
    @category_slug = category_slug
  end

  def uri
    "#{category_slug}##{slug}"
  end
end