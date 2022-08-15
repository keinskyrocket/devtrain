require_relative './output'
require 'json'
require 'time'

class Stats
  def create_game_log
    if !File.file?('log.txt')
      file_opened = File.new('log.txt', 'w')
      file_opened.close
    end
  end

  def save_game_log(word, game_property)
    individual_log = {
      timestamp: Time.now.utc.strftime('%Y-%m-%d %H:%M:%S'),
      game_won: game_property[:game_won],
      numberOfGuessFail: game_property[:wrong_letters_answered].length,
      secretWord: word
    }

    File.open('log.txt', 'a') { |f| f << individual_log.to_json + "\n" }
  end

  def read_game_log
    all_logs = File.open('log.txt') do |f|
      f.map { |log| JSON.parse(log.strip) }
    end

    logs_for_wins = all_logs.select { |el| el["game_won"] }
    times_guessed_to_win = logs_for_wins.map { |el| el["numberOfGuessFail"] + el["secretWord"].split.size }

    times_game_played = all_logs.length
    times_game_won = logs_for_wins.length

    if times_game_won < 1
      game_won_rate = 0
      avg_times_guessed_to_win = 0
    else
      game_won_rate = (times_game_won * 100) / times_game_played
      avg_times_guessed_to_win = times_guessed_to_win.sum / times_game_won
    end

    { 
      times_game_played: times_game_played,
      times_game_won: times_game_won,
      game_won_rate: game_won_rate,
      avg_times_guessed_to_win: avg_times_guessed_to_win,
    }    
  end
end


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
  ## Number of guess [fail]
  ## (Secret word?)


##### Reading lifetime stats
# Find a file that saved the history of the previous game play
# Grab necesarry data and display following:
  ## % game won
  ## Number of game won / played
  ## Avg number of guesses used to win


# Ask player if they want to keep playing

# {
#   "history": [
#     {
#       "timestamp": "yyyy-mm-dd",
#       "result" : "win",
#       "numberOfGuessTotal": "xxx",
#       "numberOfGuessFail": "xxx",
#       "secretWord": "turtle"
#     },
#     {
#       "timestamp": "yyyy-mm-dd",
#       "result" : "lose",
#       "numberOfGuessTotal": "xxx",
#       "numberOfGuessFail": "xxx",
#       "secretWord": "hat"
#     },
#   ]
# }
