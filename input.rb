class Input
  def initialize(console_input = $stdin, console_output = $stdout)
    @console_input = console_input
    @console_output = console_output
  end

  def get_answer
    loop do
      answer = @console_input.gets.chomp

      if answer.match?(/^[yY]$/)
        @console_output.puts "Play again"
        break
      elsif answer.match?(/^[nN]$/)
        @console_output.puts "Bye"
        return true
      end

      @console_output.puts "Either 'y' or 'n' is allowed."
    end
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
end
