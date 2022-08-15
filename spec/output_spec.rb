require_relative '../output'

describe Output do
  describe "#start" do
    let(:output) { StringIO.new }

    it 'should display welcome message' do
      Output.new(output).start
      expect(output.string).to include "\n******************************"
      expect(output.string).to include "Welcome to HANGMAN!"
      expect(output.string).to include "Guess a secret word"
      expect(output.string).to include "You have 9 times to guess..."
      expect(output.string).to include "******************************"
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

    it 'should display game stats' do
      read_game_log = {
        times_game_played: 10,
        times_game_won: 5,
        game_won_rate: 50,
        avg_times_guessed_to_win: 3
      }

      Output.new(output).display_stats(read_game_log)
      expect(output.string).to include "Number of game played:"
    end
  end
end
