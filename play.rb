require_relative "./hangman"
require_relative "./game_runner"

game_runner(lambda { hangman })

# require_relative "./player_wants_to_stop_playing"

# loop do
#   hangman

#   if player_wants_to_stop_playing
#     break
#   end
# end
