require "script_node.rb"

class QuestionNode < ScriptNode

  attr_accessor :speaker, :child_node

  def initialize(parent)
    super(parent)
    @type = :question
  end

end
