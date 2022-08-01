require_relative "./hangman"

input = Input.new($stdin, $stdout)

loop do
  hangman = Hangman.new
  hangman.play

  break unless input.ask_replay_game
end
