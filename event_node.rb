require "script_node.rb"

class EventNode < ScriptNode

  def initialize(options={})
    options[:type] = :event
    super(options)
  end

  def render(view)
    dialogue = self
    view.app do
      view.append do
        dialogue.view = stack do
          flow do
            para "Event"
            stack(margin: 5, width: 26, height: 26) do
              image "images/delete.png", width: 16, height: 16
            end.click{dialogue.parent.delete(dialogue)}
          end
          edit_line.change do |text|
            dialogue.text = text
          end
        end
      end
    end
  end

end

