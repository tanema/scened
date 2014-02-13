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
      case node["type"]
      when "dialogue"
        DialogueNode.new node.merge(parent: self)
      when "question"
        QuestionNode.new node.merge(parent: self)
      when "answer"
        AnswerNode.new node.merge(parent: self)
      when "event"
        EventNode.new node.merge(parent: self)
      when "camera"
        CameraNode.new node.merge(parent: self)
      else
        p node[:type]
      end
    end
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

  def add_event
    @event = EventNode.new(parent: self)
    @child_nodes.push(@event)
    @event.render(@child_view)
  end

  def add_camera
    @camera = CameraNode.new(parent: self)
    @child_nodes.push(@camera)
    @camera.render(@child_view)
  end

  def delete(node)
    node.view.remove
    @child_nodes.delete(node)
  end

  def to_json(*a)
    json_data = {
      type: @type,
      text: @text || ""
    }
    json_data[:child_nodes] = @child_nodes if @child_nodes.any?
    json_data[:speaker] = @speaker if @speaker
    JSON.generate(json_data)
  end

end
