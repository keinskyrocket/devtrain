require_relative '../input'

describe Input do
  let(:output) { StringIO.new }
  describe '#ask_replay_game' do
    it 'should show the error message if typed other than "y" or "n"' do
      Input.new(build_input('e4', 'gahgefawgaw3/#*🤡tr', 'n'.chars), output).ask_replay_game
      expect(output.string).to include '==> Do you want to play it again? <y/n>'
      expect(output.string).to include "Either 'y' or 'n' is allowed."
    end

    it 'should be falsy if typed "n"' do
      result = Input.new(build_input('n'.chars), output).ask_replay_game
      expect(result).to be_falsy
      expect(output.string).to include '==> Do you want to play it again? <y/n>'
      expect(output.string).to include "Bye"
    end

    it 'should be truthy if typed "y"' do
      result = Input.new(build_input('y'.chars), output).ask_replay_game
      expect(result).to be_truthy
      expect(output.string).to include '==> Do you want to play it again? <y/n>'
      expect(output.string).to include "Play again"
    end

    def build_input(*letters)
      StringIO.new(letters.join("\n") + "\n")
    end
  end

  describe '#get_guess' do
    it 'Does not allow non-letter guesses' do
      Input.new(build_input('3/#*🤡turle'.chars), output).get_guess
      expect(output.string).to include 'Only allow single letter guesses'
      expect(output.string).not_to include '>> Remaining lives: 8' 
    end

    def build_input(*letters)
      StringIO.new(letters.join("\n") + "\n")
    end
  end
end