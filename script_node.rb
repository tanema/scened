class ScriptNode
  attr_accessor :type, :text, :view, :parent, :child_view, :child_nodes  

  def initialize(h={})
    require "dialogue_node.rb"
    require "question_node.rb"
    require "answer_node.rb"
    @child_nodes = []
    h.each {|k,v| instance_variable_set("@#{k}",v)}
  end

  def add_dialogue
    @dialogue = DialogueNode.new(parent: self)
    @child_nodes.push(@dialogue)
    @dialogue.render(@child_view)
  end

  def add_question
    @question = QuestionNode.new(parent: self)
    @child_nodes.push(@question)
    @question.render(@child_view)
  end

  def add_answer
    @answer = AnswerNode.new(parent: self)
    @child_nodes.push(@answer)
    @answer.render(@child_view)
  end

  def delete(node)
    node.view.remove
    @child_nodes.delete(node)
  end
end
