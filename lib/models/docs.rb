class Docs

	@@matcher = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

	def self.all
		results = []
		Dir.glob(File.join($docs_path, '*.md')).each do |path|
      results.push(self.parse_file(path))
    end

    results
	end

	def self.find(category, topic = nil)
		self.matches(self.all, :topic, '0000') { |list|
			self.matches(list, :nice_name, category) { |list|
				return list if topic.nil? || list.empty?

				self.matches(self.all, :category, list.first[:category]) { |list|
					self.matches(list, :nice_name, topic)
				}
			}
		}
	end

	private

	def self.matches(list, key, value)
		results = list.select {|doc| doc[key.to_sym].to_s == value.to_s }
		block_given? ? yield(results) : results
	end

	def self.parse_file(path)
    return unless path
    return unless File.exists?(path)
    @found = true

    data = {}

    # set category, topic, and nice name from the filename
    filename = path.gsub($docs_path + '/', '')
    category_id, topic_id, nice_name = filename.split('-')
    data[:category] = category_id
    data[:topic] = topic_id
    data[:nice_name] = nice_name.gsub('.md', '')

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