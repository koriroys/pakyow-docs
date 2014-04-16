require 'pathname'

class Docs

  MATCHER = /^(---\s*\n.*?\n?)^(---\s*$\n?)/m

  class << self
    def load
      @results = []
      config = YAML.load(File.read('docs/_order.yaml'))
      config.each { |category|
        result = { nice_name: category, topics: [] }

        Dir.glob(File.join($docs_path, category, '*.md')).each do |path|
          topic = parse_file(path)
          topic[:category_nice_name] = category

          if topic[:nice_name] == '_overview'
            result[:name] = topic[:name]
            topic[:nice_name] = 'overview'

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
        result[:topics].sort! { |a,b|
          i_a = topic_order.index(a[:nice_name])
          i_b = topic_order.index(b[:nice_name])

          i_a.to_i <=> i_b.to_i
        }
        @results << result
      }
    end

    def all
      @results
    end

    alias_method :find_categories, :all

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

    private

    def parse_file(path)
      data = {}
      pn = Pathname.new(path)

      data[:nice_name] = pn.basename(".*").to_s

      raw = File.read(path)

      options = YAML.load(raw.match(MATCHER).to_s)
      data[:name] = options['name']

      data[:body] = raw.gsub(MATCHER, '')
      data
    end
  end
end