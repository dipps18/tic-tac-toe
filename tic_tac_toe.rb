# frozen_string_literal: true

require 'pry'
class Game
  attr_accessor :maps, :gameover,:count
  def initialize(maps = [0, 1, 2, 3, 4, 5, 6, 7, 8])
    @maps = maps
    @gameover = false
    @winning_positions = [[0, 4, 8], [0, 1, 2], [0, 3, 6], [2, 4, 6], [2, 5, 8], [6, 7, 8], [1, 4, 7], [3, 4, 5]]
    @count = 0
    print_screen
  end

  def print_screen
    puts "\n       |       |\n"
    puts "   #{@maps[0]}   |   #{@maps[1]}   |   #{@maps[2]}"
    puts "_______|_______|_______\n"
    puts "       |       |\n"
    puts "   #{@maps[3]}   |   #{@maps[4]}   |   #{@maps[5]}"
    puts "_______|_______|_______\n"
    puts "       |       |           \n"
    puts "   #{@maps[6]}   |   #{@maps[7]}   |   #{@maps[8]}"
    puts "       |       |           \n\n"
  end
  def end_game(player)
    @gameover = true
    player.player_won = true
  end
  
  def update_player_position(player, position)
    @maps[position.to_i] = player.player
    player.position.push(position.to_i)
  end
  
  def check_winner(player)
    @winning_positions.each do |element|
      if element.sort.intersection(player.position).length == 3
        end_game(player)
        @gameover = true
        return true
      end
    end
  end
  
  def update_player(player, position, turn)
    update_player_position(player, position)
    print_screen
    puts "Player #{turn} won the game!" if check_winner(player) == true
  end
end

class Player
  attr_accessor :player, :position, :player_won

  def initialize
    @position = []
    @player = ''
  end

  def set_character(taken_character = nil)
    if taken_character.nil?
      puts "Input any character you like\n"
      @player = gets.chomp[0]
    else
      loop do
        puts "Input any character you like except #{taken_character}\n"
        @player = gets.chomp[0]
        break unless @player == taken_character
      end
    end
  end
end

game = Game.new
player1 = Player.new
player2 = Player.new
puts 'Player 1 >>'
player1.set_character
puts 'Player 2 >>'
player2.set_character(player1.player)
game.print_screen
while game.gameover == false && game.count != 9
  turn = game.count.even? ? 1 : 2
  loop do
    puts "Player #{turn}>> Please enter the position where you would like your marker"
    position = gets.chomp
    next unless game.maps.include?(position.to_i)
    turn == 1 ? game.update_player(player1, position, turn) : game.update_player(player2, position, turn)
    game.count = game.count + 1
    game.gameover = true if game.count == 9
    break
  end
end
puts "Draw" if game.count == 9