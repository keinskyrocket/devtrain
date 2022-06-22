require_relative '../game_runner'

describe '#game_runner' do

  it 'should show the error message if typed other than "y" or "n"' do
    output = StringIO.new
    game_runner(build_input('e4', 'gahgefawgaw3/#*🤡tr', 'n'.chars), output)
    expect(output.string).to include "Either 'y' or 'n' is allowed."
  end

  it 'should exit the game if typed "n"' do
    output = StringIO.new
    game_runner(build_input('n'.chars), output)
    expect(output.string).to include "Bye"
  end

  it 'should restart the game if typed "y"' do
    output = StringIO.new
    game_runner(build_input('y'.chars), output)
    expect(output.string).to include "Play again"
  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end