require "script_node.rb"

class AnswerNode < ScriptNode

  def initialize(parent)
    super(parent)
    @type = :answer
  end

end           
