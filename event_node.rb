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
        event.view = stack do
          flow do
            para "Event"
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{event.parent.delete(event)}
          end
          edit_line(text: event.text).change do |text|
            event.text = text
          end
        end
      end
    end
  end

end

