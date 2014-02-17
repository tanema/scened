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
        character.view = stack margin: 5 do
          border "#D9D9D9", curve: 3
          flow margin: 5 do
            image("images/character.png", width: 32, height: 32, margin: 3, margin_right: 5).click do
              character.focus
            end
            edit_line(width: "70%", text: character.name, top: 2).change do |line|
              character.name = line.text
              @name_display.text = line.text if @name_display
            end
            image("images/delete_character.png", width: 20, height: 20, right: 0, top: 5).click do
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
  end

  def focus(focus_conv=nil)
    character = self
    focus_conv = focus_conv || @conversations[0]
    @script_view.clear
    @script_view.app do
      @focused_character = character
      @script.script_view.append do
        @name_display = tagline character.name, align: 'center'
        flow width: "100%" do
          character.conversations.each_with_index do |conversation, index|
            flow(width: 120, margin_right: 2, height: 25) do
              if focus_conv and focus_conv == conversation
                background "#EDEDED"
                border "#D3D3D3"
              else
                background "#D3D3D3"
              end
              flow do
                stack(width: -26) do
                  para (index + 1).to_s, margin_left: 12
                end.click do
                  character.focus(conversation)
                end
                stack(margin: 5, width: 26, height: 26, right: 0) do
                  image "images/delete.png", width: 16, height: 16
                end.click do
                  character.delete(conversation)
                end
              end
            end
          end
        end
        @conv_view = stack
        if focus_conv
          focus_conv.render(@conv_view)
        end
      end
    end
  end

  def add_conversation(child_nodes=[])
    conversation = Conversation.new(
      parent: self,
      child_nodes: child_nodes
    )
    @conversations.push(conversation)
    self.focus(conversation)
  end

  def delete(conversation)
    conversation.view.remove
    @conversations.delete(conversation)
    self.focus
  end

  def to_json(*a)
    JSON.generate(@conversations)
  end

end
