class Category
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
  attr_reader :slug, :name, :overview, :topics

  def initialize(slug)
    @slug = slug
    @name = nil
    @topics = []
    @overview = nil
  end

  def process_topics!
    topic_files_paths = Dir.glob(File.join("docs", @slug, '*.md'))
    topic_files_paths.each do |topic_file_path|
      topic = parse_file(topic_file_path)

      if category_heading?(topic)
        set_category_attributes(topic)
      else
        append_topic_to_topics_list(topic)
      end

      sort!
    end
  end

  private

  def category_heading?(topic)
    topic[:slug] == '_overview'
  end

  def set_category_attributes(topic)
    @name = topic[:name]
    @overview = topic[:body]
  end

  def append_topic_to_topics_list(topic)
    @topics << topic
  end

  def parse_file(path)
    topic = {}
    pn = Pathname.new(path)
    raw = pn.read

    topic[:slug] = pn.basename(".*").to_s
    topic[:name] = YAML.load(raw.match(MATCHER).to_s)['name']
    topic[:body] = raw.gsub(MATCHER, '')
    topic[:category_slug] = @slug
    topic
  end

  def topic_order
    @topic_order ||= YAML.load(File.read(path))
  end

  def path
    @path ||= File.join($docs_path, @slug, '_order.yaml')
  end

  def sort!
    @topics.sort! { |a,b|
      i_a = topic_order.index(a[:slug])
      i_b = topic_order.index(b[:slug])
      i_a.to_i <=> i_b.to_i
    }
  end
end

