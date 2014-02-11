require "conversation.rb"

class Character
  attr_accessor :name, :view, :conversations, :nodes
  
  def initialize
    @conversations = []
    @nodes = []
  end

  def render(view)
    character = self
    @view = view
    view.app do
      view.append do
        character_view = flow margin: 5 do
          image("images/character.png", width: 32, height: 32, margin: 3).click do
            character.focus(character)
          end
          edit_line(width: 100).change do |text|
            character.name = text
            character.focus(character)
          end
          image("images/delete_character.png", width: 20, height: 20).click do
            if confirm("Are you sure?")
              character_view.remove
              script.characters.delete(character)
            end
          end
        end
        character.focus(character)
      end
    end
  end

  def focus
    character = self
    view = @view
    view.children.each do |element|
      element.remove
    end
    view.app do
      view.append do
        flow do
          para character.name
          stack(margin: 5, width: 42, height: 42) do
            image "images/add_conversation.png", width: 32, height: 32
          end.click do
            character.add_conversation
          end
        end
      end
    end
  end

  def add_conversation
    @conversation = Conversation.new
    @conversations.push(@conversation)
    @conversation.render(@view)
  end

end
