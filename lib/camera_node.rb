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
        camera.view = stack margin: 5 do
          background "#999999", curve: 5
          border "#707070", curve: 5
          stack margin: 5 do
            flow do
              para "Camera"
              flow width: 130, right: 0 do
                %w(add_dialogue add_question add_event add_camera delete).each do |action|
                  stack(margin: 5, width: 26, height: 26) do
                    image "images/#{action}.png", width: 16, height: 16
                  end.click{camera.parent.send(action, camera)}
                end
              end
            end
            flow do
              para "Action  "
              list_box(items: ACTION, choose: camera.action.to_sym).change do |option|
                dialogue.action = option.text()
              end
              para "X  "
              edit_line(text: camera.x, width: "20%").change do |text|
                camera.x = text
              end
            end
            flow do
              para "Target  "
              list_box(items: TARGETS, choose: camera.target.to_sym).change do |option|
                dialogue.target = option.text()
              end
              para "Y  "
              edit_line(text: camera.y, width: "20%").change do |text|
                camera.y = text
              end
            end
          end
        end
      end
    end
  end

end
