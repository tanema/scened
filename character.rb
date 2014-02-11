class Character
  attr_accessor :name_field, :script_view, :nodes
  
  def initialize(script_view)
    @nodes = []
    @script_views = script_view
  end

  def name
    self.name_field.text()
  end

  def name=(text)
    self.name_field = text
  end

  def add_dialogue
    character = self
    character.app do
      character.script_view.append do
        dialogue = DialogueNode.new
        stack do
        end
        character.nodes.push(dialogue)
      end
    end
  end

  def add_question
    character = self
    character.app do
      character.script_view.append do
        question = QuestionNode.new
        stack do
        end
        character.nodes.push(question)
      end
    end
  end
end
