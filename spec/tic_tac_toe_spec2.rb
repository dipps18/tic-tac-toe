
require_relative '../lib/tic_tac_toe.rb'

describe Player do
  describe "#set_character" do
  subject(:player_character) { described_class.new }

    context 'when taken character is nil' do
      context 'when input is invalid and then valid' do
        before do
          allow(player_character).to receive(:gets).and_return('','x')
        end

        it 'should enter loop twice' do
          message = "Input any character you like\n"
          expect(player_character).to receive(:puts).with(message).twice
          player_character.set_character
        end
      end

      context 'when input is invalid, invalid and then valid' do
        before do
          allow(player_character).to receive(:gets).and_return('','  ', 'x')
        end
        it 'should enter loop thrice' do
          message = "Input any character you like\n"
          expect(player_character).to receive(:puts).with(message).thrice
          player_character.set_character
        end
      end

      context 'when input is valid' do
        before do
          allow(player_character).to receive(:gets).and_return('O')
        end
        it 'should enter loop once' do
          message = "Input any character you like\n"
          expect(player_character).to receive(:puts).with(message).once
          player_character.set_character
        end
      end
    end

    context 'When taken character is not nil' do

      context 'when input is taken character(invalid) and then valid' do
        before do
          allow(player_character).to receive(:gets).and_return('X', 'O')
        end

        it 'should enter loop twice' do
          taken_character = 'X'
          message = "Input any character you like except #{taken_character}\n"
          expect(player_character).to receive(:puts).with(message).twice
          player_character.set_character(taken_character)
        end
      end

      context 'When input is invalid non taken character, invalid and then valid' do
        before do
          allow(player_character).to receive(:gets).and_return('', 'X', 'O')
        end
        
        it 'should enter loop thrice' do
          taken_character = 'X'
          message = "Input any character you like except #{taken_character}\n"
          expect(player_character).to receive(:puts).with(message).thrice
          player_character.set_character(taken_character)
        end
      end

      context 'When input is valid' do
        before do
          allow(player_character).to receive(:gets).and_return('O')
        end

        it 'should enter loop once' do
          taken_character = 'X'
          message = "Input any character you like except #{taken_character}\n"
          expect(player_character).to receive(:puts).with(message).once
          player_character.set_character(taken_character)
        end
      end
    end
  end
end