class TopicParser
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  attr_reader :pn, :topic, :category_slug, :order

  def initialize(pn, category_slug, order)
    @pn = pn
    @category_slug = category_slug
    @order = order
  end

  def topic
    Topic.new(
      slug: slug,
      name: name,
      body: body,
      category_slug: category_slug,
      order: order
    )
  end

  def slug
    @slug ||= pn.basename(".*").to_s
  end

  def name
    @name ||= YAML.load(raw.match(MATCHER).to_s)['name']
  end

  def body
    @body ||= raw.gsub(MATCHER, '')
  end

  private

  def raw
    @raw ||= pn.read
  end

  attr_reader :manifest
end
