require_relative "./hangman"
require_relative "./game_runner"

loop do
  hangman

  if game_runner
    break
  end
end
