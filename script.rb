require "character.rb"
require "conversation.rb"
require "json"

class Script < Shoes::Stack
  attr_accessor :list_view, :script_view, :characters

  def initialize
    @characters = []
  end

  def add_character
    @character = Character.new(self, @list_view, @script_view)
    @characters.push(@character)
    @character.render
  end

  def open
    @file = ask_open_file
    @json = File.read(filename)
    obj = JSON.parse(json)
  end

  def save
    unless @file 
      @file = ask_save_file 
    end
    File.open(@file, "w") do |f|
      f.write(self.to_json)
    end
  end

  def delete(character)
    character.view.remove
    @characters.delete(character)
  end

  def to_json
    JSON.generate(Hash[@characters.map{|c| [c.name, c]}])
  end

end
