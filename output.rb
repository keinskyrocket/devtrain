require 'pry-byebug'

class Output
  BLOCK_SYMBOL = 9609.chr("UTF-8")

  def initialize(console_output = $stdout)
    @console_output = console_output
  end

  def start
    @console_output.puts "\n******************************"
    @console_output.puts "Welcome to HANGMAN!"
    @console_output.puts "Guess a secret word"
    @console_output.puts "You have 9 times to guess..."
    @console_output.puts "******************************"
  end

  def display_progress(display_current, wrong_letters_answered)
    replacement_of_nil = display_current.map{ |el| el.nil? ? BLOCK_SYMBOL : el }.join ## el.nil? = if el ==
    @console_output.puts "\nSecret word: #{replacement_of_nil}"
    @console_output.puts "Wrong letters answered: #{wrong_letters_answered}\n\n"
    @console_output.puts "---------- Pick a letter!! ----------"
  end

  def has_duplicates(guess)
    @console_output.puts "\n>> You have already picked '#{guess}'."
  end

  def display_guess_result(success)
    if success
      @console_output.puts "\n>> Yes :D"
    else
      @console_output.puts "\n>> Not that one!" 
    end
  end

  def display_remaining_lives(max_lives, wrong_letters_answered)
    @console_output.puts ">> Remaining lives: #{max_lives - wrong_letters_answered.length}"
  end

  def end(word, game_won)
    @console_output.puts "\n\n******************************"
    @console_output.puts game_won ? "Win. Yes, it is '#{word}'" : "Lose. The answer is '#{word}'"
    @console_output.puts "******************************"
  end

  def ask_replay_game
    @console_output.puts "==> Do you want to play it again? <y/n>"
  end
end
