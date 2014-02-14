require "script_node.rb"

class EventNode < ScriptNode

  def initialize(options={})
    options[:type] = :event
    super(options)
  end

  def render(view)
    event = self
    view.app do
      view.append do
        event.view = stack margin: 5 do
          background "#E5FF00", curve: 5
          border "#D8F000", curve: 5
          stack margin: 5 do
            flow do
              para "Event"
              flow width: 130, right: 0 do
                %w(add_dialogue add_question add_event add_camera delete).each do |action|
                  stack(margin: 5, width: 26, height: 26) do
                    image "images/#{action}.png", width: 16, height: 16
                  end.click{event.parent.send(action, event)}
                end
              end
            end
            edit_line(text: event.text, width: "100%", height: 35).change do |line|
              event.text = line.text
            end
          end
        end
      end
    end
  end

end

