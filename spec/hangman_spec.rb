require_relative '../hangman'

describe Hangman do
  describe '#play' do
    it 'should end the game if all lives are consumed' do
      output = StringIO.new
      hangman = Hangman.new(build_input('qweryuiop'.chars), output, 'hat')

      game_property = {
        hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
        game_won: false,
        wrong_letters_answered: ['q', 'w', 'e', 'r', 'y', 'u', 'i', 'o', 'p']
      }

      hangman.play
      expect(game_property[:game_won]).to be false
      expect(game_property[:wrong_letters_answered].length).to eq 9
    end

    it 'should end the game if the secret word is revealed' do
      output = StringIO.new
      hangman = Hangman.new(build_input('hat'.chars), output, 'hat')

      game_property = {
        hash_of_word: [ { letter: 'h', validation: true }, { letter: 'a', validation: true }, { letter: 't', validation: true } ],
        game_won: true,
        wrong_letters_answered: []
      }

      hangman.play
      expect(game_property[:game_won]).to be true
      expect(game_property[:wrong_letters_answered].length).not_to eq 9
    end

    it 'should ask users to type a guess unless all lives are consumed or the secret word is revealed' do
      output = StringIO.new
      hangman = Hangman.new(build_input('plshat'.chars), output, 'hat')

      game_property = {
        hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
        game_won: false,
        wrong_letters_answered: ['p', 'l', 's']
      }

      hangman.play
      expect(game_property[:game_won]).to be false
      expect(game_property[:wrong_letters_answered].length).not_to eq 9
    end
  end

  describe '#take_turn' do
    context 'when guess is repeated' do
      it 'warns user and does not remove life' do
        output = StringIO.new
        hangman = Hangman.new(build_input('q'), output, 'hat')

        game_property = {
          hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
          game_won: false,
          wrong_letters_answered: ['q']
        }

        new_game_property = hangman.take_turn(game_property)
        expect(new_game_property[:wrong_letters_answered]).to include 'q'
        expect(new_game_property[:wrong_letters_answered].length).to eq 1
      end
    end

    context 'when guess is a new letter' do
      context 'when guess is a correct letter' do
        it 'should reveal the letter from the secret word' do
          output = StringIO.new
          hangman = Hangman.new(build_input('h'), output, 'hat')

          game_property = {
            hash_of_word: [ { letter: 'h', validation: true }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: []
          }

          new_game_property = hangman.take_turn(game_property)
          expect(new_game_property[:hash_of_word][0][:validation]).to be true
          expect(new_game_property[:wrong_letters_answered].length).to eq 0
        end
      end

      context 'when guess is an incorrect letter' do 
        it 'should record the letter and lose a life' do
          output = StringIO.new
          hangman = Hangman.new(build_input('kgm'.chars), output, 'hat')

          game_property = {
            hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: ['k', 'g', 'm']
          }

          new_game_property = hangman.take_turn(game_property)
          expect(new_game_property[:hash_of_word][0][:validation]).to be false
          expect(new_game_property[:wrong_letters_answered].length).to eq 3
        end
      end
    end
  end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
