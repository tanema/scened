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
        answer.view = stack margin: 2 do
          background "#00F757", curve: 5
          border "#00CC47", curve: 5
          stack margin: 5 do
            flow do
              para "Answer"
              flow width: 130, right: 0 do
                %w(add_dialogue add_question add_event add_camera).each do |action|
                  action_button = stack(margin: 5, width: 26, height: 26) do
                    image "images/#{action}.png", width: 16, height: 16
                  end.click{answer.send(action, nil)}
                end
                stack(margin: 5, width: 26, height: 26) do
                  image "images/delete.png", width: 16, height: 16
                end.click{answer.parent.delete(answer)}
              end
            end
            edit_box(text: answer.text, width: "100%", height: 35).change do |box|
              answer.text = box.text
            end
          end
        end
        flow do
          stack width: "5%"
          answer.child_view = stack width: "95%" 
        end
      end
    end
    render_children
  end

end           
