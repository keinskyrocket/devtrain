require_relative '../hangman'

describe 'Hangman game integration test' do
  before(:each) do
    filename = 'log.txt'

    allow(File).to receive(:new).with(filename, 'w').and_return(StringIO.new(''))
    allow(File).to receive(:open).with(filename, any_args).and_yield(StringIO.new(''))
  end

  it 'Can win a game' do
    output = StringIO.new
    Hangman.new(build_input('turtle'.chars), output, 'turtle').play
    expect(output.string).to include "Win. Yes, it is 'turtle'"
  end

  it 'Can lose a game' do
    output = StringIO.new
    Hangman.new(build_input('pzxymnhqg'.chars), output, 'turtle').play
    expect(output.string).to include "Lose. The answer is 'turtle'"
  end
  
  it 'Tells a validation message against a wrong letter input' do
    output = StringIO.new
    Hangman.new(build_input('pqwjcysmk'.chars), output, 'turtle').play
    expect(output.string).to include '>> Not that one!'
  end

  it 'Refuses duplicates' do
    output = StringIO.new
    Hangman.new(build_input('tturle'.chars), output, 'turtle').play
    expect(output.string).to include "\n>> You have already picked 't'."
    expect(output.string).not_to include '>> Remaining lives: 8' 
  end

  it 'Loses lives when incorrect letter is chosen' do
    output = StringIO.new
    Hangman.new(build_input('pqwjcysmk'.chars), output, 'turtle').play
    expect(output.string).to include '>> Remaining lives: 5'
  end

  it 'Shows the current progress of the secret letter' do
    output = StringIO.new
    Hangman.new(build_input('trqwsxcvbnm'.chars), output, 'turtle').play
    expect(output.string).to include 'Secret word: t▉rt'
  end

  it 'Shows wrong letters answered' do
    output = StringIO.new
    Hangman.new(build_input('trqwsxcvbnm'.chars), output, 'turtle').play    
    expect(output.string).to include 'Wrong letters answered: ["q", "w", "s", "x", "c", "v", "b", "n"]'
    expect(9 - build_input.length).to eq(8)
  end

  it 'Does not allow non-letter guesses' do
    output = StringIO.new
    Hangman.new(build_input('3/#*🤡turle'.chars), output, 'turtle').play
    expect(output.string).to include 'Only allow single letter guesses'
    expect(output.string).not_to include '>> Remaining lives: 8' 
  end

  it 'should show game stats when game ends' do
    output = StringIO.new
    Hangman.new(build_input('turtle'.chars), output, 'turtle').play
    expect(output.string).to include 'Number of game played: 0'
    expect(output.string).to include 'Number of game won: 0'
    expect(output.string).to include 'Game won rate: 0'
    expect(output.string).to include 'Avg number of guesses used to win: 0'
  end
  ## json.parse is doing something wrong?

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
