require "script.rb"

Shoes.app do
  @script = Script.new

  stack do
    flow do
      @script.list_view = stack(width: 200) do
        flow do
          %w(add_character open save).each do |action|
            action_button = stack(margin: 5, width: 42, height: 42) do
              image "images/#{action}.png", width: 32, height: 32
            end
            action_button.click{@script.send(action)}
          end
        end
      end
      @script.script_view = stack(width: -200)
    end
  end

end
