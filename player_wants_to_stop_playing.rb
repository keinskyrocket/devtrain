require 'pry-byebug'

def player_wants_to_stop_playing(console_input = $stdin, console_output = $stdout)
  output = Output.new(console_output)
  input = Input.new(console_input, console_output)

  output.ask_replay_game
  input.get_answer
end
