class ScriptNode
  attr_accessor :type, :text, :view, :parent, :child_view, :child_nodes  

  def initialize(h={})
    require "dialogue_node.rb"
    require "question_node.rb"
    require "answer_node.rb"
    require "event_node.rb"
    require "camera_node.rb"
    @child_nodes = []
    h.each {|k,v| instance_variable_set("@#{k}",v)}
    @child_nodes = @child_nodes.map do |node|
      Object.const_get("#{node["type"].capitalize}Node").new node.merge(parent: self) 
    end
  end

  %w(dialogue question answer event camera).each do |node|
    define_method "add_#{node}" do
      new_node = Object.const_get("#{node.capitalize}Node").new(parent: self)
      @child_nodes.push(new_node)
      new_node.render(@child_view)
    end
  end

  def delete(node)
    node.view.remove
    @child_nodes.delete(node)
  end

  def to_json(*a)
    json_data = {}
    self.instance_variables.select do |var|
      ![:@parent, :@child_view, :@view].include?(var)
    end.each do |var|
      json_data[var.to_s.delete "@"] = self.instance_variable_get var
    end
    JSON.generate(json_data)
  end

end
