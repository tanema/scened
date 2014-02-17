require "script_node.rb"

class DialogueNode < ScriptNode

  SPEAKER_TYPES = [:character, :player, :narrator]

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
        dialogue.view = stack margin: 2 do
          background "#5CDCFF", curve: 5
          border "#4FC3E3", curve: 5
          stack margin: 5 do
            flow do
              para "Dialogue"
              flow width: 130, right: 0 do
                %w(add_dialogue add_question add_event add_camera delete).each do |action|
                  action_button = stack(margin: 5, width: 26, height: 26) do
                    image "images/#{action}.png", width: 16, height: 16
                  end.click{dialogue.parent.send(action, dialogue)}
                end
              end
            end
            flow do
              para "Speaker  "
              list_box(items: SPEAKER_TYPES, choose: dialogue.speaker.to_sym).change do |option|
                dialogue.speaker = option.text()
              end
            end
            edit_box(text: dialogue.text, width: "100%", height: 35).change do |box|
              dialogue.text = box.text
            end
          end
        end
      end
    end
  end

end
