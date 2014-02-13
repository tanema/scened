require "script_node.rb"

class CameraNode < ScriptNode
  
  ACTION = [:pan, :jump, :focus]
  TARGETS = [:character, :player, :position]

  attr_accessor :action, :target, :x, :y

  def initialize(options={})
    @action = ACTION[0] 
    @target = TARGETS[0] 
    options[:type] = :camera
    super(options)
  end

  def render(view)
    camera = self
    view.app do
      view.append do
        camera.view = stack do
          flow do
            para "Camera"
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{camera.parent.delete(camera)}
          end
          list_box(items: ACTION, choose: camera.action).change do |option|
            dialogue.action = option.text()
          end
          list_box(items: TARGETS, choose: camera.target).change do |option|
            dialogue.target = option.text()
          end
          edit_line(text: camera.x).change do |text|
            camera.x = text
          end
          edit_line(text: camera.y).change do |text|
            camera.y = text
          end
        end
      end
    end
  end

end
