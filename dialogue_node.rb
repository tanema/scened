require "script_node.rb"

class DialogueNode < ScriptNode

  SPEAKER_TYPES = %i(character player)

  attr_accessor :speaker, :parent_node, :child_node

  def initialize(parent)
    super(parent)
    @type = :dialogue
    @speaker = SPEAKER_TYPES[0]
  end

end
