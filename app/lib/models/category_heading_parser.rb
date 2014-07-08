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
