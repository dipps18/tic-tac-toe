
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

  # describe '#update_player_position' do
  #   subject(:game_update) { described_class.new }
  #   let(:player_update) { instance_double(Player) }

  #   context 'When updating player position' do
  #     before do
  #       position = 3
  #       allow(player_update).to receive(:player_marker).and_return('X')
  #       allow(player_update).to receive(:position).and_return(position)
  #     end

  #     it 'adds 3 to player position' do
  #       expect(player_update).to receive(:position)
  #       game_update.update_player_position(player_update, '3')
  #     end
  #   end
  # end

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
    context '@gameover is true and count is 9' do
      
    end

    context '@gameover is false and count is 9' do
      
    end  context '@gameover is false and count is 7' do
      
    end  context '@gameover is false and count is 9' do
      
    end
  end

end