require "script_node.rb"
require "dialogue_node.rb"
require "question_node.rb"

class AnswerNode < ScriptNode

  def initialize(options={})
    options[:type] = :answer
    super(options)
  end

  def render(view)
    answer = self
    view.app do
      view.append do
        answer.view = stack do
          para "Answer"
          edit_box.change do |text|
            answer.text = text
          end
          flow do
            %w(add_dialogue add_question delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{answer.send(action)}
            end
          end
          answer.child_view = stack
        end
      end
    end
  end

end           
