require_relative '../player_wants_to_stop_playing'

describe '#player_wants_to_stop_playing' do
  it 'should call "ask_replay_game" method' do
    output = StringIO.new
    expect(output).to receive(:ask_replay_game)
    output.ask_replay_game
  end

  it 'should call "get_answer" method' do
    input = StringIO.new
    expect(input).to receive(:get_answer)
    input.get_answer
  end
end