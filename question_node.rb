require "script_node.rb"
require "answer_node.rb"

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
          para "Question"
          edit_box.change do |text|
            question.text = text
          end
          flow do
            %w(add_answer delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{question.send(action)}
            end
          end
          question.child_view = stack
        end
      end
    end
  end

end
