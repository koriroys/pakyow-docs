class Docs

	@@matcher = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

	def self.all
    return @results if @results && Pakyow.app.env == :production

    @results = []
    config = YAML.load(File.read('docs/_order.yaml'))
    config.each { |category|
      result = {nice_name: category, topics: []}

      Dir.glob(File.join($docs_path, category, '*.md')).each do |path|
        topic = self.parse_file(path)
        topic[:category_nice_name] = category

        if topic[:nice_name] == '_overview'
          result[:name] = topic[:name]

          topic[:nice_name] = 'overview'
          # topic[:name] = 'Overview'

          result[:topics].unshift(topic)
        else
          result[:topics] << topic
        end
      end

      topic_order = YAML.load(
        File.read(
          File.join($docs_path, category, '_order.yaml')
        )
      )

      # sort em
      result[:topics].sort! { |a,b|
        i_a = topic_order.index(a[:nice_name])
        i_b = topic_order.index(b[:nice_name])

        i_a.to_i <=> i_b.to_i
      }

      @results << result
    }

    return @results
	end

	def self.find(category)
    all.each { |c|
      return c[:topics] if c[:nice_name] == category
    }
	end

	def self.find_categories
    all
	end

	def self.find_topics(category)
    all.inject([]) { |matches, c|
      matches.concat(c[:topics]) if c[:nice_name] == category
      matches
    }
  end

	private

	def self.parse_file(path)
    return unless path
    return unless File.exists?(path)
    @found = true

    data = {}

    filename = path.gsub($docs_path + '/', '')
    data[:nice_name] = filename.split('/')[-1].gsub('.md', '')

    # is this a draft?
    data[:draft] = true if path.split('.')[-1] == 'draft'

    raw = File.read(path)#.split("\n")

    options = YAML.load(raw.match(@@matcher).to_s)
    data[:name] = options['name'].gsub("\"", '').strip

    # get body
    data[:body] = raw.gsub(@@matcher, '')

    data
  end
end