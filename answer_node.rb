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
          flow do
            para "Answer"
            %w(add_dialogue add_question add_event add_camera).each do |action|
              action_button = stack(margin: 5, width: 26, height: 26) do
                image "images/#{action}.png", width: 16, height: 16
              end
              action_button.click{answer.send(action)}
            end
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{answer.parent.delete(answer)}
          end
          edit_box(text: answer.text).change do |box|
            answer.text = box.text
          end
          flow do
            stack width: "10%"
            answer.child_view = stack width: "90%" 
          end
        end
      end
    end
    render_children
  end

end           
