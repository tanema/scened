class ScriptNode
  attr_accessor :type, :text, :nest_level, :parent_node

  def initialize(parent)
    @parent_node = parent
    @nest_level = if @parent_node
        @parent_node.nest_level + 1
      else
        0
      end
  end

end
