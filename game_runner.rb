require 'pry-byebug'

def game_runner(play_game, console_input = $stdin, console_output = $stdout)
  loop do
    play_game.call

    console_output.puts "==> Do you want to play it again? <y/n>"

    loop do
      answer = console_input.gets.chomp
  
      if !answer.match?(/(^(y|n))+$/) # The letter start and end with y or n (only accept single letter: y or n)
        console_output.puts "Either 'y' or 'n' is allowed."
      elsif answer == 'n'
        console_output.puts "Bye"
        exit
      elsif answer == 'y'
        console_output.puts "Play again"
        break
      end
    end
  end
end
