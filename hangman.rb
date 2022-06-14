# Initialise setting
  # Set player's remaining lives to be 9
  # Set game_won to false
  # Pick a secret word out of many

# Show welcome message and rule

# While game is not over (collection.length < MAX_LIVES and game_won is false)
  # Display the secret word 
    # with a non letter character if not revealed yet (false)
    # with the correct letter if already revealed (true)

  # Get player's guess
  
  # Check if guess is valid
    # If guess is not in the word
      # Tell them the letter is wrong
      # Return to start of loop
    # If guess is in the collection of guess already
      # Tell them the letter has been already guessed
      # Return to start of loop
  
    # Add guess to guess collection

  # If guess is in the word
    # Set the letter true
#(Game is over)

# If game_won is true
  # Tell them they won
# Otherwise
  # Tell them they lost