class SimpleArticleFormat
  def self.load(file)
    content = File.read file
    new(content).parse
  end

  def initialize(content)
    @content = content
    @entities = []
  end

  def parse
    entities = @content.strip.split "---"
    entities.map do |entity|
      parse_entity entity
    end.compact
  end

  private

  REGEX = /^(\w+):\s+(.+?)$|^(\w+)>([^<]+)</m

  def textile(text)
    RedCloth.new(text).to_html
  end

  def parse_entity(entity_string)
    entity = {}
    entity_string.scan(REGEX).each do |matches|
      name, value = matches.compact
      entity[name.to_sym] = textile value.strip
    end
    return if entity == {}
    entity
  end
end

Saf = SimpleArticleFormat