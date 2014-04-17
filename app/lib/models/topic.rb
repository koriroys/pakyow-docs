class Topic
  attr_reader :name, :body, :slug, :category_slug, :order

  def initialize(name, body, slug, category_slug, order)
    @name = name
    @body = body
    @slug = slug
    @category_slug = category_slug
    @order = order
  end

  def uri
    "#{category_slug}##{slug}"
  end
end