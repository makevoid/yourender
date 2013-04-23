class Guide

  @@guides = []

  attr_accessor :current

  def initialize(name_url)
    @name_url = name_url
    @current = @@guides.find{ |guide| guide.id == get_idx }
  end

  def next
    guide = @@guides[@current.id+1]
    # RELEASE: remove in open source relase
    guide = @@guides[@current.id+2] if guide.name_url[1] == "b"
    guide = @@guides[@current.id+2] if guide.name_url == "4a_connect_osx"
    next_guide = Guide.new guide.name_url
    if next_guide.id == 4
      url = next_guide.os == "osx" ? "4a_connect_osx" : "4b_connect_win"
      next_guide.current.name_url = url
    end
    next_guide
  end

  def id
    @current.id
  end

  def name
    @current.name
  end

  def name_url
    @current.name_url
  end

  def message_next # RELEASE: remove in open source relase
    if id == 2
      "nell'ultimo passaggio troverai i link per proseguire al prossimo step"
    end
  end

  def os
    case @name_url
      when /osx/    then "osx"
      when /win/    then "win"
      when /linux/  then "linux"
    end
  end

  # class methods

  def self.load(guides=[])
    @@guides = guides
  end

  def self.all
    @@all ||= @@guides.map{ |guide| Guide.new guide.name_url }
  end

  private

  def get_idx
    @name_url.split("_")[0].to_i
  end

end