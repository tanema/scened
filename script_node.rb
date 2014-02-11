class ScriptNode
  attr_accessor :type, :text, :nest_level, :view, :child_view, 
                :child_node, :child_nodes  

  def initialize(h={})
    @child_nodes = []
    h.each {|k,v| instance_variable_set("@#{k}",v)}
  end

  def add_dialogue
    @dialogue = DialogueNode.new
    @child_node = @dialogue
    @dialogue.render(@child_view)
  end

  def add_question
    @question = QuestionNode.new
    @child_node = @question
    @question.render(@child_view)
  end

  def add_answer
    @answer = AnswerNode.new
    @child_nodes.push(@answer)
    @answer.render(@child_view)
  end

  def delete
    @view.remove
  end

end
