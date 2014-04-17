class Category
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
      topic_parser = TopicParser.new(topic_file_path, slug)
      if category_heading?(topic_parser.slug)
        set_category_attributes(topic_parser.name, topic_parser.body)
      else
        topic = Topic.new(topic_parser.to_hash)
        append_topic_to_topics_list(topic)
      end
    end
    sort!
  end

  private

  def category_heading?(slug)
    slug == "_overview"
  end

  def set_category_attributes(name, overview)
    @name = name
    @overview = overview
  end

  def append_topic_to_topics_list(topic)
    @topics << topic
  end

  def sort!
    @topics.sort_by!(&:order)
  end
end

