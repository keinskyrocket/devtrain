require_relative '../hangman'

describe 'Hangman game integration test' do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  it 'Can win a game' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('t', 'u', 'r', 'l', 'e')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include "Win. Yes, it is 'turtle'"
  end

  it 'Can lose a game' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('p', 'z', 'x', 'y', 'm', 'n', 'h', 'q', 'g')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include "Lose. The answer is 'turtle'"
  end
  
  it 'Tells a validation message against a wrong letter input' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('p', 'q', 'w', 'j', 'c', 'y', 's', 'm', 'k')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include '>> Not that one!'
  end

  it 'Refuses duplicates' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('t', 't', 'u', 'r', 'l', 'e')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include "\n>> You have already picked 't'."
    expect(output.string).not_to include '>> Remaining lives: 8' 
  end

  it 'Loses lives when incorrect letter is chosen' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('p', 'q', 'w', 'j', 'c', 'y', 's', 'm', 'k')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include '>> Remaining lives: 5'
  end

  it 'Shows the current progress of the secret letter' do
    allow_any_instance_of(Input).to receive(:get_guess).and_return('t', 'r', 'q', 'w', 's', 'x', 'c', 'v', 'b', 'n', 'm')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include 'Secret word: t▉rt'
  end

  it 'Shows wrong letters answered' do
    # allow_any_instance_of(Input).to receive(:get_guess).and_return('t', 'r', 'q', 'w', 's', 'x', 'c', 'v', 'b', 'n', 'm')

    input_moc = instance_double(Input)

    allow(Input).to receive(:new).and_return(input_moc)
    allow(input_moc).to receive(:get_guess).and_return('t', 'r', 'q', 'w', 's', 'x', 'c', 'v', 'b', 'n', 'm')

    Hangman.new(input, output, 'turtle').play
    expect(output.string).to include 'Wrong letters answered: ["q", "w", "s", "x", "c", "v", "b", "n"]'
    expect(9 - [input].length).to eq(8)
  end

  it 'Does not allow non-letter guesses' do
    # allow_any_instance_of(Input).to receive(:get_guess).and_return('3', '/', '#', '*', '🤡', 't', 'u', 'r', 'l', 'e')
    # Hangman.new(input, output, 'turtle').play
    
    Hangman.new(build_input('3/#*🤡turle'.chars), output, 'turtle').play

    expect(output.string).to include 'Only allow single letter guesses'
    expect(output.string).not_to include '>> Remaining lives: 8' 
  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
