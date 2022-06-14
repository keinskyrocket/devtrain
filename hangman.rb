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
