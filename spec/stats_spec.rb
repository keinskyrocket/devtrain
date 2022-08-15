require_relative '../stats'

describe Stats do
  let(:filename) { 'log.txt' }

  describe '#create_game_log' do
    context 'when there is no log file' do
      it 'should create a new file' do
        file_mock = instance_double('File')

        allow(File).to receive(:file?).and_return(false)
        expect(File).to receive(:new).with(filename,'w').and_return(file_mock)
        expect(file_mock).to receive(:close)
        Stats.new.create_game_log
      end
    end

    context 'when there is log file' do
      it 'should not do anything' do
        allow(File).to receive(:file?).and_return(true)
        expect(File).not_to receive(:new)
        Stats.new.create_game_log
      end
    end
  end

  describe '#save_game_log' do
    context 'when game is finished' do
      it 'should add one game record' do
        mock_file = []
        allow(File).to receive(:file?).and_return(true)
        expect(File).to receive(:open).with(filename, 'a').and_yield(mock_file)

        game_property = {
          hash_of_word: [ { letter: 'h', validation: false }, { letter: 'a', validation: false }, { letter: 't', validation: false } ],
          game_won: false,
          wrong_letters_answered: []
        }

        new_stats = Stats.new.save_game_log('hat', game_property)

        expect(mock_file.length).to be(1)
        expect(mock_file[0]).to include "\"game_won\":false"
      end
    end
  end

  describe '#read_game_log' do
    context 'when player has never won' do
      it 'should still return the stats' do
        log_content = <<~FILE
          {"timestamp":"2022-08-11 04:03:12","game_won":false,"numberOfGuessFail":9,"secretWord":"moral"}
          {"timestamp":"2022-08-11 04:04:59","game_won":false,"numberOfGuessFail":9,"secretWord":"fiji"}
        FILE
        
        allow(File).to receive(:file?).and_return(true)
        expect(File).to receive(:open).with(filename).and_yield(StringIO.new(log_content))

        new_stats = Stats.new.read_game_log

        expect(new_stats[:times_game_won]).to eq 0
        expect(new_stats[:game_won_rate]).to eq 0
      end
    end

    context 'when player has never played' do
      it 'should still return the stats' do
        log_content = ''
  
        allow(File).to receive(:file?).and_return(true)
        expect(File).to receive(:open).with(filename).and_yield(StringIO.new(log_content))

        new_stats = Stats.new.read_game_log

        expect(new_stats[:times_game_won]).to eq 0
        expect(new_stats[:game_won_rate]).to eq 0
      end
    end

    context 'when player has already won more than once' do
      it 'should return the stats' do
        log_content = <<~FILE
          {"timestamp":"2022-08-11 04:03:12","game_won":false,"numberOfGuessFail":9,"secretWord":"moral"}
          {"timestamp":"2022-08-11 04:04:59","game_won":false,"numberOfGuessFail":9,"secretWord":"fiji"}
          {"timestamp":"2022-08-11 22:44:41","game_won":true,"numberOfGuessFail":2,"secretWord":"situated"}
        FILE

        allow(File).to receive(:file?).and_return(true)
        expect(File).to receive(:open).with(filename).and_yield(StringIO.new(log_content))

        new_stats = Stats.new.read_game_log

        expect(new_stats[:times_game_won]).to be 1
        expect(new_stats[:game_won_rate]).to be 33
      end
    end
  end
end
