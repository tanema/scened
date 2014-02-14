require "script_node.rb"

class Conversation < ScriptNode

  def render(view)
    conversation = self
    view.app do
      view.append do
        conversation.view = stack do
          flow do
            para conversation.parent.conversations.index(conversation) + 1
            %w(add_dialogue add_question add_event add_camera).each do |action|
              action_button = stack(margin: 5, width: 42, height: 42) do
                image "images/#{action}.png", width: 32, height: 32
              end
              action_button.click{conversation.send(action, nil)}
            end
            stack(margin: 5, width: 42, height: 42) do
              image "images/delete.png", width: 32, height: 32
            end.click{conversation.parent.delete(conversation)}
          end
          flow do
            stack width: "10%"
            conversation.child_view = stack width: "90%"
          end
        end
      end
    end
    render_children
  end

  def to_json(*a)
    JSON.generate(@child_nodes)
  end

end
