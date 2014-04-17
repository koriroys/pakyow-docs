class TopicParser
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  attr_reader :pn, :topic, :category_slug

  def initialize(path, category_slug)
    @path = path
    @category_slug = category_slug
    @pn = Pathname.new(path)
    @topic = {}
  end

  def to_hash
    {
      slug: slug,
      name: name,
      body: body,
      category_slug: category_slug,
      order: order
    }
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

  def order
    topic_order.index(slug)
  end

  def raw
    @raw ||= @pn.read
  end

  def topic_order
    @topic_order ||= YAML.load(File.read(manifest_path))
  end

  def manifest_path
    @manifest_path ||= File.join($docs_path, category_slug, '_order.yaml')
  end
end

