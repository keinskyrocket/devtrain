# require_relative '../player_wants_to_stop_playing'

# describe '#player_wants_to_stop_playing' do
#   it 'should show the error message if typed other than "y" or "n"' do
#     output = StringIO.new
#     player_wants_to_stop_playing(build_input('e4', 'gahgefawgaw3/#*🤡tr', 'n'.chars), output)
#     expect(output.string).to include "Either 'y' or 'n' is allowed."
#   end

#   it 'should exit the game if typed "n"' do
#     output = StringIO.new
#     player_wants_to_stop_playing(build_input('n'.chars), output)
#     expect(output.string).to include "Bye"
#   end

#   it 'should restart the game if typed "y"' do
#     output = StringIO.new
#     player_wants_to_stop_playing(build_input('y'.chars), output)
#     expect(output.string).to include "Play again"
#   end

#   def build_input(*letters)
#     StringIO.new(letters.join("\n") + "\n")
#   end
# end
