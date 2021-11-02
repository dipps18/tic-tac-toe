
require_relative '../lib/tic_tac_toe.rb'

describe Game do
  describe '#initialize' do
    # initialize -> no tests necessary since it is only creating instance variables
  end

  describe '#play_game' do
    # Public Script method -> No tests necessary but all functions inside should be tested
  end

  describe '#game_over?' do
    context 'When player has a 3 markers on top row' do
      subject(:game_over) { described_class.new }
      let(:player) {double(Player)}
      before do
        allow(player).to receive(:position).and_return([0,1,2])
      end
      it 'gameover should return true' do
        expect(game_over.instance_variable_get(:@gameover)).to eql(true)
        game_over(player)
      end
    end
  end
end