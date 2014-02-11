require "character"

class Script < Shoes::Stack
  attr_accessor :list_view, :script_view, :characters, :focused_character

  def initialize
    @characters = []
  end

  def add_character
    script = self
    script.list_view.app do
      script.list_view.append do
        character = Character.new
        flow margin: 5 do
          image("images/character.png", width: 32, height: 32, margin: 3).click do
            script.focused_character = character
          end
          stack width: 100 do
            character.name_field = edit_line width: 100
          end
          image("images/delete_character.png", width: 20, height: 20).click do
            character.remove
            script.characters.delete(character)
          end
          script.characters.push(character)
          script.focused_character = character
        end
      end
    end
  end

  def add_dialogue
    if @focused_character
    else
      alert "no selected character"
    end
  end

  def add_question
    if @focused_character
    else
      alert "no selected character"
    end
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
