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
        question.view = stack do
          flow do
            para "Question"
            stack(margin: 5, width: 26, height: 26) do
              image "images/add_answer.png", width: 16, height: 16
            end.click{question.add_answer}
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{question.parent.delete(question)}
          end
          edit_box.change do |text|
            question.text = text
          end
          flow do
            stack width: "10%"
            question.child_view = stack width: "90%" 
          end
        end
      end
    end
  end

end
