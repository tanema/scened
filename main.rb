require "script.rb"

Shoes.setup do
end

Shoes.app title: "Scened", width: 1000, height: 700 do
  @script = Script.new
  background white

  stack do
    flow do
      @script.list_view = stack(width: 200) do
        @toolbar = flow do
          %w(add_character open save).each do |action|
            action_button = stack(margin: 5, width: 42, height: 42) do
              image "images/#{action}.png", width: 32, height: 32
            end
            action_button.click{@script.send(action)}
          end
          @add_conv = stack(margin: 5, width: 42, height: 42) do
            image "images/add_conversation.png", width: 32, height: 32
          end.click do
            @focused_character.add_conversation if @focused_character
          end
        end
      end
      @script.script_view = stack(width: -200, right: 0)
    end
  end

end
