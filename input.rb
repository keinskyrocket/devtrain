class Input
  def initialize(console_input = $stdin, console_output = $stdout)
    @console_input = console_input
    @console_output = console_output
  end

  def get_guess
    loop do
      guess = @console_input.gets.chomp
      
      if guess.match?(/^[a-zA-Z]$/)
        return guess.downcase
      end

      @console_output.puts "Only allow single letter guesses"
    end
  end

  def ask_replay_game
    @console_output.puts "==> Do you want to play it again? <y/n>"

    loop do
      answer = @console_input.gets.chomp

      if answer.match?(/^[yY]$/)
        @console_output.puts "Play again"
        return true
      elsif answer.match?(/^[nN]$/)
        @console_output.puts "Bye"
        return false
      end

      @console_output.puts "Either 'y' or 'n' is allowed."
    end
  end
end
