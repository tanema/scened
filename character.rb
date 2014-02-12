require "conversation.rb"

class Character
  attr_accessor :name, :script, :list_view, :script_view, 
                :conversations, :nodes, :view, :name_display
  
  def initialize(script, list_view, script_view)
    @conversations = []
    @script = script
    @list_view = list_view
    @script_view = script_view
  end

  def render
    character = self
    view = @list_view
    view.app do
      view.append do
        character.view = flow margin: 5 do
          image("images/character.png", width: 32, height: 32, margin: 3).click do
            character.focus
          end
          edit_line(width: 100).change do |line|
            character.name = line.text
            character.name_display.text = line.text if character.name_display
          end
          image("images/delete_character.png", width: 20, height: 20).click do
            if confirm("Are you sure?")
              character.script_view.clear
              character.script.delete(character)
            end
          end
        end
        character.focus
      end
    end
  end

  def focus
    character = self
    view = @script_view
    view.clear
    view.app do
      view.append do
        flow do
          character.name_display = para character.name
          stack(margin: 5, width: 42, height: 42) do
            image "images/add_conversation.png", width: 32, height: 32
          end.click do
            character.add_conversation
          end
        end
      end
    end
    @conversations.each do |conversation|
      conversation.render(@script_view)
    end
  end

  def add_conversation
    @conversation = Conversation.new(parent: self)
    @conversations.push(@conversation)
    @conversation.render(@script_view)
  end

  def delete(conversation)
    conversation.view.remove
    @conversations.delete(conversation)
  end

  def to_json(*a)
    JSON.generate(@conversations)
  end

end
