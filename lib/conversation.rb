require "script_node.rb"

class Conversation < ScriptNode

  def render(view)
    conversation = self
    view.app do
      view.append do
        conversation.view = stack margin_bottom: 2 do
          background "#EDEDED"
          border "#D3D3D3"
          stack margin: 5 do
            flow do
              flow width: 130, right: 0 do
                %w(add_dialogue add_question add_event add_camera).each do |action|
                  action_button = stack(margin: 5, width: 26, height: 26) do
                    image "images/#{action}.png", width: 16, height: 16
                  end.click{conversation.send(action, nil)}
                end
              end
            end
          end
        end
        flow do
          conversation.child_view = stack
        end
      end
    end
    render_children
  end

  def to_json(*a)
    JSON.generate(@child_nodes)
  end

end
