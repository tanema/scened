require "script_node.rb"
require "question_node.rb"

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
        dialogue.view = stack(left: (dialogue.nest_level * 20), width: -(dialogue.nest_level * 20))  do
          para "Dialogue"
          list_box(items: DialogueNode::SPEAKER_TYPES).change do |option|
            dialogue.speaker = option.text()
          end
          edit_box.change do |text|
            dialogue.text = text
          end
          flow do
            %w(add_dialogue add_question  delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{dialogue.send(action)}
            end
          end
          dialogue.child_view = stack
        end
      end
    end
  end

end
