require 'pry-byebug'
require_relative './input'
require_relative './output'

class Hangman
  MAX_LIVES = 9
  WORDS = File.open('words.txt').map { |word| word.strip }

  def initialize(console_input = $stdin, console_output = $stdout, word = nil)
    @output = Output.new(console_output)
    @input = Input.new(console_input, console_output)
    @word = word || WORDS.sample ## word ? word : WORDS.sample
  end

  def play
    game_property = {
      hash_of_word: @word.chars().map { |letter| {letter: letter, validation: false} },
      game_won: false,
      wrong_letters_answered: []
    }

    @output.start

    while game_property[:wrong_letters_answered].length < MAX_LIVES && !game_property[:game_won] do
      game_property = take_turn(game_property)
    end

    @output.end(@word, game_property[:game_won])
  end

  def take_turn(game_property)
    new_game_property = {
      hash_of_word: game_property[:hash_of_word].dup,
      game_won: game_property[:game_won].dup,
      wrong_letters_answered: game_property[:wrong_letters_answered].dup
    }

    display_current = new_game_property[:hash_of_word].map { |el| !el[:validation] ? nil : el[:letter] }
    @output.display_progress(display_current, new_game_property[:wrong_letters_answered])
    guess = @input.get_guess

    if new_game_property[:wrong_letters_answered].include?(guess) || new_game_property[:hash_of_word].any? { |el| el[:letter] === guess && el[:validation] }
      @output.has_duplicates(guess)
    else
      guess_is_correct = new_game_property[:hash_of_word].any? { |el| el[:letter] === guess && !el[:validation] }

      if guess_is_correct
        new_game_property[:hash_of_word].each { |el| el[:validation] = true if el[:letter] === guess }
      else
        new_game_property[:wrong_letters_answered] << guess
      end

      @output.display_guess_result(guess_is_correct)
    end

    new_game_property[:game_won] = new_game_property[:hash_of_word].all? { |el| el[:validation] }
    @output.display_remaining_lives(MAX_LIVES, new_game_property[:wrong_letters_answered])

    new_game_property
  end
end

# Initialise setting
  # Set player's remaining lives to be 9
  # Pick a secret word out of many
  # Create an array of object(letter_validation) out of the secret word
  # [
  #   {letter: "A", valid: false},
  #   {letter: "B", valid: false},
  #   {letter: "C", valid: false},
  #   ...
  # ]

# Show welcome message and rule

# While game is not over (collection.length < MAX_LIVES and letter_validation has false)
  # Display initial/updated secret word 
    # with a non letter character if not revealed yet (false)
    # with the correct letter if already revealed (true)
  # Get player's guess
  
  # Check if guess is in the collection of guess already or the letter is already revealed
    # Tell them the letter has been already guessed
    # Return to start of loop

  # Otherwise
    # Check if guess is not in the word
      # Tell them the letter is wrong
      # Add guess to guess collection
      # Return to start of loop

    # Check if guess is in the word
      # Set the letter true
      # Return to start of loop
#(Game is over)

# If letter_validation is all true
  # Tell them they won
# Otherwise
  # Tell them they lost
  # Reveal the answer

# Show replay option at the end of the game
# Restart the game
  # Reset wrong_letters_answered
  # Pick a new secret word