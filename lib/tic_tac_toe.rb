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

  def play_game()
    player1 = Player.new
    player2 = Player.new
    puts 'Player 1 >>'
    player1.set_character
    puts 'Player 2 >>'
    player2.set_character(player1.player)
    print_screen
    game_loop(player1, player2)
    puts 'Draw' if @count == 9
  end

  def game_loop(player1, player2)
    while @gameover == false && @count != 9
      turn = @count.even? ? 1 : 2
      loop do
        puts "Player #{turn}>> Please enter the position where you would like your marker"
        position = gets.chomp
        next unless @maps.include?(position.to_i)

        turn == 1 ? update_player(player1, position, turn) : update_player(player2, position, turn)
        @count += 1
        @gameover = true if @count == 9
        break
      end
    end
  end

  def print_screen
    puts "\n"
    puts "       |       |\n"
    puts "   #{@maps[0]}   |   #{@maps[1]}   |   #{@maps[2]}"
    puts "_______|_______|_______\n"
    puts "       |       |\n"
    puts "   #{@maps[3]}   |   #{@maps[4]}   |   #{@maps[5]}"
    puts "_______|_______|_______\n"
    puts "       |       |           \n"
    puts "   #{@maps[6]}   |   #{@maps[7]}   |   #{@maps[8]}"
    puts "       |       |           \n\n"
  end

  def update_player(player, position, turn)
    update_player_position(player, position)
    print_screen
    puts "Player #{turn} won the game!" if game_over?(player) == true
  end

  def update_player_position(player, position)
    @maps[position.to_i] = player.player
    player.position.push(position.to_i)
  end

  def game_over?(player)
    @winning_positions.each do |element|
      next unless (element.sort & player.position).length == 3
        return @gameover = true
      end
    end
  end


end
# class for player
class Player

  attr_accessor :player, :position

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
game.play_game
