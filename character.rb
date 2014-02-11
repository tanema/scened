require "dialogue_node.rb"
require "question_node.rb"

class Character
  attr_accessor :name_field, :script_view, :nodes
  
  def initialize(script_view)
    @nodes = []
    @script_view = script_view
  end

  def name
    self.name_field.text()
  end

  def name=(text)
    self.name_field = text
  end

  def add_dialogue(parent=nil)
    view = @script_view
    character = self
    view.app do
      view.append do
        dialogue = DialogueNode.new(parent)
        stack(left: (dialogue.nest_level * 20), width: -(dialogue.nest_level * 20))  do
          para "Dialogue"
          list_box items: DialogueNode::SPEAKER_TYPES
          edit_box
          flow do
            %w(add_dialogue add_question  delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{dialogue.send(action, dialogue)}
            end
          end
        end
        character.nodes.push(dialogue)
      end
    end
  end

  def add_question(parent=nil)
    view = @script_view
    character = self
    view.app do
      view.append do
        question = QuestionNode.new(parent)
        stack do
          para "Question"
          edit_box
          flow do
            %w(add_answer delete).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{dialogue.send(action, dialogue)}
            end
          end
        end
        character.nodes.push(question)
      end
    end
  end

  def delete(node)

  end

end
