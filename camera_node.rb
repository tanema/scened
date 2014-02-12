require "script_node.rb"

class CameraNode < ScriptNode
  
  ACTION = [:pan, :jump, :focus]
  TARGETS = [:character, :player]

  attr_accessor :action, :target

  def initialize(options={})
    @acion = SPEAKER_TYPES[0] 
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
          list_box(items: ACTION, choose: @action).change do |option|
            dialogue.speaker = option.text()
          end
          list_box(items: TARGETS, choose: @target).change do |option|
            dialogue.speaker = option.text()
          end
          edit_line.change do |text|
            camera.text = text
          end
        end
      end
    end
  end

end
