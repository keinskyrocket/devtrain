require_relative '../input'

describe Input do
  describe '#get_answer' do
    it 'should show the error message if typed other than "y" or "n"' do
      output = StringIO.new
      Input.new(build_input('e4', 'gahgefawgaw3/#*🤡tr', 'n'.chars), output).get_answer
      expect(output.string).to include "Either 'y' or 'n' is allowed."
    end

    it 'should exit the game if typed "n"' do
      output = StringIO.new
      Input.new(build_input('n'.chars), output).get_answer
      expect(output.string).to include "Bye"
    end

    it 'should restart the game if typed "y"' do
      output = StringIO.new
      Input.new(build_input('y'.chars), output).get_answer
      expect(output.string).to include "Play again"
    end

    context 'when typed "y"' do
      it 'should restart the game' do
        output = StringIO.new
        Input.new(build_input('y'.chars), output).get_answer
        expect(output.string).to include "Play again"
      end
    end

    def build_input(*letters)
      StringIO.new(letters.join("\n") + "\n")
    end
  end
end