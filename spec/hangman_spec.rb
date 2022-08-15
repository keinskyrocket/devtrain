require_relative '../hangman'

describe Hangman do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before(:each) do
    stats_results = {
      times_game_played: 10,
      times_game_won: 5,
      game_won_rate: 50,
      avg_times_guessed_to_win: 6,
    }

    allow_any_instance_of(Stats).to receive(:create_game_log)
    allow_any_instance_of(Stats).to receive(:save_game_log)
    allow_any_instance_of(Stats).to receive(:read_game_log).and_return(stats_results)
  end

  describe '#play' do
    it 'should end the game if all lives are consumed' do
      allow_any_instance_of(Input).to receive(:get_guess).and_return('q', 'w', 'e', 'r', 'y', 'u', 'i', 'o', 'p')
      expect_any_instance_of(Output).to receive(:end).with('hat', false)
      
      Hangman.new(input, output, 'hat').play
    end

    it 'should end the game if the secret word is revealed' do
      allow_any_instance_of(Input).to receive(:get_guess).and_return('h', 'a', 't')
      expect_any_instance_of(Output).to receive(:end).with('hat', true)
      
      Hangman.new(input, output, 'hat').play
    end
  end

  describe '#take_turn' do
    it 'should display the current progress of the game' do
      allow_any_instance_of(Input).to receive(:get_guess).and_return('h', 'a', 't')
      expect_any_instance_of(Output).to receive(:display_progress).with([nil, nil, nil], [])

      hangman = Hangman.new(input, output, 'hat')

      game_property = {
        hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
        game_won: false,
        wrong_letters_answered: []
      }

      new_game_property = hangman.take_turn(game_property)
      expect(new_game_property[:wrong_letters_answered]).to eq []
    end
    
    context 'when guess is repeated' do
      it 'warns user and does not remove life' do
        allow_any_instance_of(Input).to receive(:get_guess).and_return('q')  ## rspec magic -> stubbing fake input
        expect_any_instance_of(Output).to receive(:has_duplicates).with('q') 

        hangman = Hangman.new(input, output, 'hat')

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
          allow_any_instance_of(Input).to receive(:get_guess).and_return('h')

          hangman = Hangman.new(input, output, 'hat')

          game_property = {
            hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: []
          }

          new_game_property = hangman.take_turn(game_property)
          expect(new_game_property[:hash_of_word][0][:validation]).to be true
          expect(new_game_property[:wrong_letters_answered].length).to eq 0
        end

        it 'should tell the user the guess is correct' do
          allow_any_instance_of(Input).to receive(:get_guess).and_return('h')
          expect_any_instance_of(Output).to receive(:display_guess_result).with(true)

          game_property = {
            hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: []
          }
          
          Hangman.new(input, output, 'hat').take_turn(game_property)
        end

        context 'when the guess completes the word' do
          it 'should win the game' do
            allow_any_instance_of(Input).to receive(:get_guess).and_return('t')

            hangman = Hangman.new(input, output, 'hat')
  
            game_property = {
              hash_of_word: [ { letter: 'h', validation: true }, { letter: 'a', validation: true }, { letter: 't', validation: false } ],
              game_won: false,
              wrong_letters_answered: []
            }
  
            new_game_property = hangman.take_turn(game_property)
            expect(new_game_property[:game_won]).to be true
          end
        end
      end

      context 'when guess is an incorrect letter' do 
        it 'should record the letter and lose a life' do
          allow_any_instance_of(Input).to receive(:get_guess).and_return('k')

          hangman = Hangman.new(input, output, 'hat')

          game_property = {
            hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: []
          }

          new_game_property = hangman.take_turn(game_property)
          expect(new_game_property[:hash_of_word][0][:validation]).to be false
          expect(new_game_property[:wrong_letters_answered].length).to eq 1
        end

        it 'should return "false" to display a message' do
          allow_any_instance_of(Input).to receive(:get_guess).and_return('k')
          expect_any_instance_of(Output).to receive(:display_guess_result).with(false)
          
          game_property = {
            hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
            game_won: false,
            wrong_letters_answered: []
          }
          
          Hangman.new(input, output, 'hat').take_turn(game_property)
        end
      end
    end

    context 'when guess is entered' do
      it 'should display the remaining lives' do
        # input_moc = instance_double(Input)
        # allow(Input).to receive(:new).and_return(input_moc)
        # allow(input_moc).to receive(:get_guess).and_return('k')

        allow_any_instance_of(Input).to receive(:get_guess).and_return('k')
        expect_any_instance_of(Output).to receive(:display_remaining_lives).with(9, ['k'])

        hangman = Hangman.new(input, output, 'hat')

        game_property = {
          hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
          game_won: false,
          wrong_letters_answered: []
        }

        new_game_property = hangman.take_turn(game_property)
        expect(new_game_property[:wrong_letters_answered]).to eq ['k']
      end
    end
  end
end
