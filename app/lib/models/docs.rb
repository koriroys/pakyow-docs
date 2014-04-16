require 'pathname'

class Category
  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  def initialize(category)
    @category_name = category
    @result = { nice_name: @category_name, topics: [] }
  end

  def topics
    topic_files_paths = Dir.glob(File.join("docs", @category_name, '*.md'))

    topic_files_paths.each do |topic_file_path|
      topic = parse_file(topic_file_path)
      topic[:category_nice_name] = @category_name

      if topic[:nice_name] == '_overview'
        @result[:name] = topic[:name]
        topic[:nice_name] = 'overview'
        @result[:topics].unshift(topic)
      else
        @result[:topics] << topic
      end

      sort!
    end
    @result
  end

  private

  def parse_file(path)
    data = {}
    pn = Pathname.new(path)
    raw = pn.read
    options = YAML.load(raw.match(MATCHER).to_s)

    data[:nice_name] = pn.basename(".*").to_s
    data[:name] = options['name']
    data[:body] = raw.gsub(MATCHER, '')

    data
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
        topics << Category.new(category).topics
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