class Topic
  attr_reader :name, :body, :slug, :category_slug, :order

  def initialize(attributes = {})
    @name = attributes[:name]
    @body = attributes[:body]
    @slug = attributes[:slug]
    @order = attributes[:order]
    @category_slug = attributes[:category_slug]
  end

  def uri
    "#{category_slug}##{slug}"
  end
end