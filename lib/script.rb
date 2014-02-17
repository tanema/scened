require "character.rb"
require "conversation.rb"
require "json"

class Script < Shoes::Stack
  attr_accessor :list_view, :script_view, :characters

  def initialize
    @characters = []
  end

  def add_character(name="", conversations=[])
    @character = Character.new(
      script: self, 
      list_view: @list_view, 
      script_view: @script_view,
      name: name,
      conversations: conversations
    )
    @characters.push(@character)
    unless conversations.any?
      @character.add_conversation
    end
  end

  def open
    if (@characters.any? and confirm("You will lose all unsaved data, are you sure you want to open a file?")) || @characters.empty?
      self.import
    end
  end

  def import
    @file = ask_open_file
    if @file
      @characters.each do |character|
        self.delete(character)
      end
      @json = File.read(@file)
      JSON.parse(@json).each do |name, conversations|
        add_character(name, conversations)
      end
    end
  end

  def save
    unless @file 
      @file = ask_save_file 
    end
    if @file 
      File.open(@file, "w") do |f|
        f.write(self.to_json)
      end
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
