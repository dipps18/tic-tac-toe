
require_relative '../lib/tic_tac_toe.rb'

describe Game do
  describe '#initialize' do
    # initialize -> no tests necessary since it is only creating instance variables
  end

  describe '#play_game' do
    # Public Script method -> No tests necessary but all functions inside should be tested
  end

  describe '#game_over?' do

  subject(:game_over) { described_class.new }
  let(:player) {instance_double(Player)}

    context 'When player has positions [0, 1, 2] (winning)' do
      before do
        allow(player).to receive(:position).and_return([0,1,2])
      end

      it '@gameover should return true' do
        expect{ game_over.game_over?(player) }.to change{game_over.instance_variable_get(:@gameover)}.to(true)
      end

      it 'game_over? should return true' do
        expect(game_over.game_over?(player)).to eql(true)
      end
    end

    context 'When player has positions [0, 2, 4] (not winning)' do
      before do
        allow(player).to receive(:position).and_return([0,2,4])
      end

      it 'game_over? should return false' do
        expect(game_over.game_over?(player)).to eql(false)
      end
    end

    context 'When player has positions [0,2,4,1] (winning)' do
      before do
        allow(player).to receive(:position).and_return([0,2,4,1])
      end

      it '@gameover should return true' do
        expect{ game_over.game_over?(player) }.to change{game_over.instance_variable_get(:@gameover)}.to(true)
      end

      it 'game_over? should return true' do
        expect(game_over.game_over?(player)).to eql(true)
      end

    end
  end

  describe '#update_player_position' do
    subject(:game_update) { described_class.new }
    let(:player_update) { instance_double(Player) }

    context 'When updating player position' do
      before do
        position = 3
        allow(player_update).to receive(:player_marker).and_return('X')
        allow(player_update).to receive(:position).and_return([3])
      end

      it 'adds 3 to player position' do
        expect(player_update.position).to eql([3])
        game_update.update_player_position(player_update, '3')
      end
    end
  end

  describe '#update_player' do
    subject(:game_update) { described_class.new }
    let(:update_player) { instance_double(Player) }
    context 'when game_over? is true and player_id is 2' do
      before do
        allow(game_update).to receive(:update_player_position)
        allow(game_update).to receive(:display_winner)
        allow(game_update).to receive(:game_over?).and_return(true)
      end

      it 'should receive display_winner' do
        position = 3
        player_id = 2
        expect(game_update).to receive(:display_winner)
        game_update.update_player(update_player, position, player_id)
      end
    end

    context 'when game_over? is false and player_id is 2' do
      before do
        allow(game_update).to receive(:update_player_position)
        allow(game_update).to receive(:display_winner)
        allow(game_update).to receive(:game_over?).and_return(false)
      end
      it 'should not receive display_winner' do
        position = 3
        player_id = 2
        expect(game_update).not_to receive(:display_winner)
        game_update.update_player(update_player, position, player_id)
      end
    end
  end

  describe '#game_loop' do

    context 'position is valid' do
      subject(:game_loop) { described_class.new }
      let(:player1) { instance_double(Player) }
      let(:player2) { instance_double(Player) }

      before do
        allow(game_loop).to receive(:puts)
        allow(game_loop).to receive(:update_player)
        game_loop.gameover = true
        allow(game_loop).to receive(:gets).and_return('0')
      end
      
      it 'should loop and output message when count is 6' do
        player_id = 1
        message = "Player #{player_id}>> Please enter the position where you would like your marker"
        expect(game_loop).to receive(:puts).with(message)
        game_loop.game_loop(player1, player2)
      end
      
      it 'should loop and output message when count is 7' do
        player_id = 2
        game_loop.count = 1
        message = "Player #{player_id}>> Please enter the position where you would like your marker"
        expect(game_loop).to receive(:puts).with(message)
        game_loop.game_loop(player1, player2)
      end

      context 'Valid input is given' do
        before do
          valid_input = '0'
          allow(game_loop).to receive(:gets).and_return(valid_input)
          game_loop.gameover = true
        end

        it 'should loop only once' do
          expect(game_loop).to receive(:puts).once
          game_loop.game_loop(player1, player2)
        end
      end
    end

    context 'position is invalid and then valid' do
      subject(:game_loop) { described_class.new(true, 0, ['X', 'X', 2, 3, 4, 'O', 'O', 6, 7, 8]) }
      let(:player1) { instance_double(Player) }
      let(:player2) { instance_double(Player) }

      before do
        allow(game_loop).to receive(:update_player)
        allow(game_loop).to receive(:puts)
        allow(game_loop).to receive(:gets).and_return(',', '2')
      end

      it 'should loop twice' do
        player_id = 1
        message = "Player #{player_id}>> Please enter the position where you would like your marker"
        expect(game_loop).to receive(:puts).with(message).twice
        game_loop.game_loop(player1, player2)
      end

    end

    context 'When position is invalid, invalid and then valid' do
      subject(:game_loop) { described_class.new(true, 0, ['X', 'X', 2, 3, 4, 'O', 'O', 6, 7, 8]) }
      let(:player1) { instance_double(Player) }
      let(:player2) { instance_double(Player) }

   
      before do
        allow(game_loop).to receive(:update_player)
        allow(game_loop).to receive(:puts)
        allow(game_loop).to receive(:gets).and_return(',', '0', '2')
      end

      it 'should loop thrice' do
        player_id = 1
        message = "Player #{player_id}>> Please enter the position where you would like your marker"
        expect(game_loop).to receive(:puts).with(message).thrice
        game_loop.game_loop(player1, player2)
      end
    end

    context 'When position isn\'t included in the map' do
      subject(:game_position) { described_class.new(true, 2, ['X', 'O', 2, 3, 4, 5, 6, 7, 8]) }
      let(:player1) { instance_double(Player) }
      let(:player2) { instance_double(Player) }

      before do
        allow(game_position).to receive(:gets).and_return('2')
        allow(game_position).to receive(:update_player).and_return(nil)
        allow(game_position).to receive(:puts)
      end

      it 'should receieve update_player' do
        expect(game_position).to receive(:update_player).once
        game_position.game_loop(player1, player2)
      end
      
      it 'should update count' do
        expect{ game_position.game_loop(player1, player2) }.to change{ game_position.count }.by(1)
      end
    end

    context 'When position is included in the map and then isn\'t' do
      subject(:game_position) { described_class.new(false, 2, ['X', 'O', 2, 3, 4, 5, 6, 7, 8]) }
      let(:player1) { instance_double(Player) }
      let(:player2) { instance_double(Player) }

      before do
        allow(game_position).to receive(:gets).and_return('0','2')
        allow(game_position).to receive(:update_player).and_return(game_position.gameover = true)
        allow(game_position).to receive(:puts)
      end
      it 'should receive update_player once' do
        expect(game_position).to receive(:update_player).once
        game_position.game_loop(player1, player2)
      end

      it 'should update count by 1' do
        expect{game_position.game_loop(player1, player2)}.to change { game_position.count }.by(1)
      end
    end

  end
end