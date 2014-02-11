require "character.rb"
require "conversation.rb"

class Script < Shoes::Stack
  attr_accessor :list_view, :script_view, :characters

  def initialize
    @characters = []
  end

  def add_character
    @character = Character.new
    @characters.push(@character)
    @character.render(@script_view)
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
end
