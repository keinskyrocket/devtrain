require_relative '../hangman'

describe 'Hangman game integration test' do
  new_game_property = {
    hash_of_word: [
      {letter: 't', validation: true},
      {letter: 'u', validation: true},
      {letter: 'r', validation: true},
      {letter: 't', validation: true},
      {letter: 'l', validation: true},
      {letter: 'e', validation: true},
    ],
    game_won: true,
    wrong_letters_answered: ['3', '/', '#', '*', '🤡']
  }

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
    Hangman.new(build_input('3/#*🤡turle'.chars), output, 'turtle').take_turn(new_game_property)
    expect(output.string).to include 'Only allow single letter guesses'
    expect(output.string).not_to include '>> Remaining lives: 8' 
  end

  it 'Does not allow more than 1 letter guessed' do
    output = StringIO.new
    Hangman.new(build_input('e4', 'gahgefawgaw3/#*🤡tr', 't', 'u', 'r', 'l', 'e'.chars), output, 'turtle').take_turn(new_game_property)
    expect(output.string).to include 'Only allow single letter guesses'
    expect(output.string).not_to include '>> Remaining lives: 8'
  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
