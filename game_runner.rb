require 'pry-byebug'

def game_runner(console_input = $stdin, console_output = $stdout)
  console_output.puts "==> Do you want to play it again? <y/n>"

  loop do
    answer = console_input.gets.chomp

    if !answer.match?(/(^(y|n))+$/) # The letter start and end with y or n (only accept single letter: y or n)
      console_output.puts "Either 'y' or 'n' is allowed."
    elsif answer == 'n'
      console_output.puts "Bye"
      return true
    elsif answer == 'y'
      console_output.puts "Play again"
      break
    end
  end
end

# Ask answer till getting the right string
  # Show the error massage if typed other than 'n' and 'y'
  # Exit the game if typed 'n'
  # Restart the game if typed 'y'