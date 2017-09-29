# Button class
class SlickButton
  attr_accessor :command

  def initialize(&command)
    @command = command
  end

  def on_button_push
    @command.call if @command
  end
end

save = -> { puts 'Handle Save' }
edit = -> { puts 'Handles Edit' }

# Supply commands when we create an instance of the button
save_button = SlickButton.new(&save)
save_button.on_button_push

edit_button = SlickButton.new(&edit)
edit_button.on_button_push
