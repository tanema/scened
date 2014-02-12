require "script_node.rb"

class DialogueNode < ScriptNode

  SPEAKER_TYPES = [:character, :player]

  attr_accessor :speaker

  def initialize(options={})
    @speaker = SPEAKER_TYPES[0] 
    options[:type] = :dialogue
    super(options)
  end

  def render(view)
    dialogue = self
    view.app do
      view.append do
        dialogue.view = stack do
          flow do
            para "Dialogue"
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{dialogue.parent.delete(dialogue)}
          end
          list_box(items: SPEAKER_TYPES, choose: @speaker).change do |option|
            dialogue.speaker = option.text()
          end
          edit_box.change do |box|
            dialogue.text = box.text
          end
        end
      end
    end
  end

end
