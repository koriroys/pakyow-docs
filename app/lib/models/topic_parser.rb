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

class CategoryHeadingParser
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  def initialize(pn)
    @pn = pn
  end

  def name
    YAML.load(raw.match(MATCHER).to_s)['name']
  end

  def overview
    raw.gsub(MATCHER, '')
  end

  private

  def raw
    @raw ||= pn.read
  end

  attr_reader :pn
end

class ManifestParser
  def initialize(category_slug)
    @category_slug = category_slug
  end

  def order(slug)
    topic_order.index(slug)
  end

  private

  def topic_order
    @topic_order ||= YAML.load(File.read(manifest_path))
  end

  def manifest_path
    @manifest_path ||= File.join($docs_path, category_slug, '_order.yaml')
  end

  attr_reader :category_slug
end
