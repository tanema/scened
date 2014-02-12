require "character.rb"
require "conversation.rb"

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
   filename = ask_open_file
   Shoes.app do
     File.read(filename)
   end
  end

  def save
    unless @file 
      save_as = ask_save_file 
    end
  end

  def delete(character)
    character.view.remove
    @characters.delete(character)
  end
end
