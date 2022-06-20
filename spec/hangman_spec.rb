require_relative '../hangman'

describe '#hangman' do
  word = 'turtle'
  
  it 'Can win a game' do
    output = StringIO.new
    hangman(word, build_input('turle'.chars), output)
    expect(output.string).to include "Win. Yes, it is 'turtle'"
  end

  it 'Can lose a game' do
    output = StringIO.new
    hangman(word, build_input('pzxymnhqg'.chars), output)
    expect(output.string).to include "Lose. The answer is 'turtle'"
  end
  
  it 'Tells a validation message against a wrong letter input' do
    output = StringIO.new
    hangman(word, build_input('pqwjcysmk'.chars), output)
    expect(output.string).to include ">> Not that one!"
  end

  it 'Refuses duplicates' do
    output = StringIO.new
    hangman(word, build_input('pqwjcysmmk'.chars), output)
    expect(output.string).to include "\n>> You have already picked 'm'."
  end

  it 'Loses lives when incorrect letter is chosen' do
    output = StringIO.new
    hangman(word, build_input('pqwjcysmk'.chars), output)
    expect(output.string).to include ">> Remaining lives: 5"
  end

  it 'Shows the current progress of the secret letter' do
    output = StringIO.new
    hangman(word, build_input('trqwsxcvbnm'.chars), output)
    expect(output.string).to include "\nSecret word: t#{BLOCK_SYMBOL}rt"
  end

  it 'Shows wrong letters answered' do
    output = StringIO.new
    hangman(word, build_input('trqwsxcvbnm'.chars), output)
    expect(output.string).to include 'Wrong letters answered: ["q", "w", "s", "x", "c", "v", "b", "n"]'
  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end