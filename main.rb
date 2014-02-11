require "script.rb"

Shoes.app do
  @script = Script.new

  stack do
    @toolbar = flow do
      %w(add_character add_dialogue add_question open save).each do |action|
        action_button = stack(margin: 5, width: 42, height: 42) do
          image "images/#{action}.png", width: 32, height: 32
        end
        action_button.click{@script.send(action)}
      end
    end
    flow do
      @script.list_view = stack(width: 200, height: slot.height - @toolbar.height) do
        border black, strokewidth: 1
      end
      @script.script_view = flow(width: -200, height: slot.height - @toolbar.height) do
        border black, strokewidth: 1
      end
    end
  end

  def do_layout
    workspace_height = slot.height - @toolbar.height
    @script.list_view.style(height: workspace_height)
    @script.script_view.style(height: workspace_height)
  end

  every(0.5) do
    do_layout()
  end
  do_layout()

end
