require_relative '../hangman'

describe Hangman do
  it 'should call "start" method' do
    output = StringIO.new
    expect(output).to receive(:start)
    output.start
  end

#   describe '#take_turn' do
#     context 'if the same letter is entered' do
#       it 'should call #has_dplicate'
#     end

#     context 'if a single letter that has not been used is entered' do
#       context 'if guess is correct' do
#         it 'should convert validation key to true'
#       end

#       context 'if guess is not correct' do
#         it 'should add the letter to an array called wrong_letter_answered'
#       end

#       it 'should call #display_guess_result'
#     end
#   end

  def build_input(*letters)
    StringIO.new(letters.join("\n") + "\n")
  end
end
