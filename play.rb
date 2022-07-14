require_relative "./hangman"
require_relative "./player_wants_to_stop_playing"

loop do
  hangman = Hangman.new
  hangman.play

  if player_wants_to_stop_playing
    break
  end
end
