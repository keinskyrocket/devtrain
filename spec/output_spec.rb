require_relative '../output'

describe Output do
  describe "#start" do
    let(:output) { StringIO.new }

    context 'When player start Hangman' do
      it 'should display welcome message' do
        Output.new(output).start
        expect(output.string).to include "\n******************************"
        expect(output.string).to include "Welcome to HANGMAN!"
        expect(output.string).to include "Guess a secret word"
        expect(output.string).to include "You have 9 times to guess..."
        expect(output.string).to include "******************************"
      end
    end

    it 'should display game progress' do
      Output.new(output).display_progress(['t', 'u', nil, 't', 'l', 'e'], ['a', 'p', 'l'])
      expect(output.string).to include 'Secret word: tu▉tle' 
      expect(output.string).to include 'Wrong letters answered: ["a", "p", "l"]'
      expect(output.string).to include '---------- Pick a letter!! ----------'
    end

    it 'should warn a dupe word is entered' do
      Output.new(output).has_duplicates('p')
      expect(output.string).to include ">> You have already picked 'p'."
    end

    it 'should display guess result' do
      Output.new(output).display_guess_result(true)
      expect(output.string).to include '>> Yes :D'

      Output.new(output).display_guess_result(false)
      expect(output.string).to include '>> Not that one!'
    end

    it 'should display remaining lives' do
      Output.new(output).display_remaining_lives(9, ['p', 'r'])
      expect(output.string).to include '>> Remaining lives: 7'
    end

    it 'should display whether player won or lost game' do
      Output.new(output).end('turtle', true)
      expect(output.string).to include "Win. Yes, it is 'turtle'"

      Output.new(output).end('turtle', false)
      expect(output.string).to include "Lose. The answer is 'turtle'"
    end

    it 'should display a message to ask whether player want to replay the game' do
      Output.new(output).ask_replay_game
      expect(output.string).to include '==> Do you want to play it again? <y/n>'
    end
  end
end
