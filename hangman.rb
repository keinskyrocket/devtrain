require 'pry-byebug'

MAX_LIVES = 9
WORDS = File.open('words.txt').map { |word| word.strip }
BLOCK_SYMBOL = 9609.chr("UTF-8")

def hangman(word = nil, console_input = $stdin, console_output = $stdout)
  console_output.puts "******************************"
  console_output.puts "Welcome to HANGMAN!"
  console_output.puts "Guess a secret word"
  console_output.puts "You have 9 times to guess..."
  console_output.puts "******************************"

  word = WORDS.sample unless word
  hash_of_word = word.chars().map { |letter| {letter: letter, validation: false} }
  game_won = false
  wrong_letters_answered = []

  while wrong_letters_answered.length < MAX_LIVES && !game_won do
    display_current = hash_of_word.map { |el| !el[:validation] ? BLOCK_SYMBOL : el[:letter] }.join

    console_output.puts "\nSecret word: #{display_current}"
    console_output.puts "Wrong letters answered: #{wrong_letters_answered}\n\n"
    console_output.puts "---------- Pick a letter!! ----------"
    guess = console_input.gets.chomp

    # puts "#{guess.size}"
    if guess.size != 1
      console_output.puts "No more than one letter is allowed."
    elsif !guess.match?(/[a-z]/)
      console_output.puts "Non-letter guesses are not allowed."
    elsif wrong_letters_answered.include?(guess) || hash_of_word.any? { |el| el[:letter] === guess && el[:validation] }
      console_output.puts "\n>> You have already picked '#{guess}'."
    elsif hash_of_word.any? { |el| el[:letter] === guess && !el[:validation] }
      hash_of_word.each { |el| el[:validation] = true if el[:letter] === guess }
      console_output.puts "\n>> Yes :D"
    else
      wrong_letters_answered << guess
      console_output.puts "\n>> Not that one!"
    end

    game_won = hash_of_word.all? { |el| el[:validation] }
    console_output.puts ">> Remaining lives: #{MAX_LIVES - wrong_letters_answered.length}"
  end

  console_output.puts "\n\n******************************"
  console_output.puts game_won ? "Win. Yes, it is '#{word}'" : "Lose. The answer is '#{word}'"
  console_output.puts "******************************"

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
