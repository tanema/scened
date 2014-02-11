class ScriptNode
  attr_accessor :type, :text, :parent_node

  def initialize(parent)
    @parent_node = parent
  end

end
