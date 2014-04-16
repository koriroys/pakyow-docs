require 'pathname'

class Category
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  def initialize(category)
    @category_name = category
    @result = { nice_name: @category_name, topics: [] }
  end

  def to_hash
    @result
  end

  def process_topics!
    topic_files_paths = Dir.glob(File.join("docs", @category_name, '*.md'))

    topic_files_paths.each do |topic_file_path|
      topic = parse_file(topic_file_path)

      if category_heading?(topic)
        prepend_category_to_topics_list(topic)
      else
        append_topic_to_topics_list(topic)
      end

      sort!
    end
  end

  private

  def category_heading?(topic)
    topic[:nice_name] == '_overview'
  end

  def prepend_category_to_topics_list(topic)
    @result[:name] = topic[:name]
    topic[:nice_name] = 'overview'
    @result[:topics].unshift(topic)
  end

  def append_topic_to_topics_list(topic)
    @result[:topics] << topic
  end

  def parse_file(path)
    topic = {}
    pn = Pathname.new(path)
    raw = pn.read

    topic[:nice_name] = pn.basename(".*").to_s
    topic[:name] = YAML.load(raw.match(MATCHER).to_s)['name']
    topic[:body] = raw.gsub(MATCHER, '')
    topic[:category_nice_name] = @category_name
    topic
  end

  def topic_order
    @topic_order ||= YAML.load(File.read(path))
  end

  def path
    @path ||= File.join($docs_path, @category_name, '_order.yaml')
  end

  def sort!
    @result[:topics].sort! { |a,b|
      i_a = topic_order.index(a[:nice_name])
      i_b = topic_order.index(b[:nice_name])
      i_a.to_i <=> i_b.to_i
    }
  end
end

class Docs
  class << self
    def load(categories)
      @results = categories.each.with_object([]) { |category, topics|
        category = Category.new(category)
        category.process_topics!
        topics << category.to_hash
      }
    end

    def all
      @results
    end

    def find(category)
      all.each { |c| return c[:topics] if c[:nice_name] == category }
      return nil
    end

    def find_topics(category)
      all.inject([]) { |matches, c|
        matches.concat(c[:topics]) if c[:nice_name] == category
        matches
      }
    end

  end
end