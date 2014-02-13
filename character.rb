require "conversation.rb"

class Character
  attr_accessor :name, :script, :list_view, :script_view, 
                :conversations, :view, :name_display
  
  def initialize(h={})
    @conversations = []
    inital_convos = h.delete(:conversations)
    h.each {|k,v| instance_variable_set("@#{k}",v)}
    (inital_convos || []).each do |conversation|
      add_conversation(conversation)
    end
    self.render
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
          debug character.name
          edit_line(width: 100, text: character.name).change do |line|
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

  def add_conversation(child_nodes=[])
    @conversation = Conversation.new(
      parent: self,
      child_nodes: child_nodes
    )
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
