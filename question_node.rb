require "script_node.rb"

class QuestionNode < ScriptNode

  def initialize(options={})
    options[:type] = :question
    super(options)
  end

  def render(view)
    question = self
    view.app do
      view.append do
        question.view = stack margin: 5 do
          background "#FC4C87", curve: 5
          border "#EB4D82", curve: 5
          stack margin: 5 do
            flow do
              para "Question"
              flow width: 52, right: 0 do
                stack(margin: 5, width: 26, height: 26) do
                  image "images/add_answer.png", width: 16, height: 16
                end.click{question.add_answer(nil)}
                stack(margin: 5, width: 26, height: 26) do
                  image "images/delete.png", width: 16, height: 16
                end.click{question.parent.delete(question)}
              end
            end
            edit_box(text: question.text, width: "100%", height: 35).change do |box|
              question.text = box.text
            end
          end
        end
        flow do
          stack width: "5%"
          question.child_view = stack width: "95%" 
        end
      end
    end
    render_children
  end

end
