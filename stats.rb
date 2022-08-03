# Launch the game

##### Check if there is a history file
# If no history file
  ## Create a blank history file
# If there is already a history file
  ## Skip this process


# Game starts (Showing the welcome message)
# ...player is playing the game
# Game ends (Win or lose, but not quit in the middle of the game)


##### Saving lifetime stats
# Add the following info to the history file:
  ## Timestamp
  ## Win or lose
  ## Number of guess [total]
  ## Number of guess [fail]
  ## (Secret word?)


##### Reading lifetime stats
# Find a file that saved the history of the previous game play
# Grab necesarry data and display following:
  ## % game won
  ## Number of game won / played
  ## Avg number of guesses used to win


# Ask player if they want to keep playing

{
  "history": [
    {
      "timestamp": "yyyy-mm-dd",
      "result" : "win",
      "numberOfGuessTotal": "xxx",
      "numberOfGuessFail": "xxx",
      "secretWord": "turtle"
    },
    {
      "timestamp": "yyyy-mm-dd",
      "result" : "lose",
      "numberOfGuessTotal": "xxx",
      "numberOfGuessFail": "xxx",
      "secretWord": "hat"
    },
  ]
}
