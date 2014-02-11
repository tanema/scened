require "dialogue_node.rb"
require "question_node.rb"

class Conversation
  attr_accessor :root_node, :view, :child_view

  def initialize
    @nodes = []
  end

  def render(view)
    conversation = self
    view.app do
      conversation.view = view.append do
        stack do
          flow do
            %w(add_dialogue add_question delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{conversation.send(action)}
            end
          end
          conversation.child_view = stack
        end
      end
    end
  end

  def add_dialogue
    @dialogue = DialogueNode.new
    @root_node = @dialogue
    @dialogue.render(@child_view)
  end

  def add_question
    @question = QuestionNode.new
    @root_node = @question
    @question.render(@child_view)
  end

  def delete
    @view.remove
  end
end
