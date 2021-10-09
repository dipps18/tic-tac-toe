require 'pry'
class Game

  def initialize(maps = [0, 1, 2, 3, 4, 5, 6, 7, 8])
    @@maps = maps
    @@gameover = false
    @@winning_positions=[[0, 4, 8], [0,1,2], [0,3,6], [2,4,6], [2,5,8], [6,7,8],[1, 4, 7], [3, 4, 5]]
    @@count = 0
    print_screen()
  end

  def self.gameover
    @@gameover
  end

  def self.count=(count)
    @@count=count
  end

  def self.gameover=(gameover)
    @@gameover=gameover
  end

  def self.maps
    @@maps
  end

  def self.count
    @@count
  end

  def self.winning_positions
    @@winning_positions
  end


  def print_screen()

    puts "\n       |       |\n"
    puts "   #{@@maps[0]}   |   #{@@maps[1]}   |   #{@@maps[2]}"
    puts "_______|_______|_______\n"
    puts "       |       |\n"
    puts "   #{@@maps[3]}   |   #{@@maps[4]}   |   #{@@maps[5]}"
    puts "_______|_______|_______\n"
    puts "       |       |           \n"
    puts "   #{@@maps[6]}   |   #{@@maps[7]}   |   #{@@maps[8]}"
    puts "       |       |           \n\n"
    end
end


class Player < Game
  attr_accessor :player, :position, :player_won
  def initialize()
    super
    @position = []
    @player=""
  end

  def print_screen()
    super
  end

  def set_character(taken_character=nil)
    if taken_character == nil
      puts "Input any character you like\n" 
      @player = gets.chomp
      @player_won = false
    else
      loop do
        puts "Input any character you like except #{taken_character}\n" 
        @player = gets.chomp
        unless @player == taken_character
          break
        end
      end
    end
  end


end

player1=Player.new()
player2=Player.new()
Game.maps
puts "Player 1 >>"
player1.set_character()
puts "Player 2 >>"
player2.set_character(player1.player)

while Game.gameover == false 
  Game.count % 2 == 0 ? turn = 1 : turn = 2
  player1.print_screen()

  loop do 

    puts "Player #{turn}>> Please enter the position where you would like your marker"
    position = gets.chomp
    if Game.maps.include?(position.to_i)
      if turn == 1 
        Game.maps[position.to_i] = player1.player
        player1.position.push(position.to_i)
        # byebug
        Game.winning_positions.each do |element| 
          if element.sort.intersection(player1.position).length==3
            Game.gameover=true;
            player1.player_won=true
            puts "Player 1 won the game!"
            player1.print_screen
            break
          end
        end
      else  
        Game.maps[position.to_i] = player2.player
        player2.position.push(position.to_i)
        # byebug
        Game.winning_positions.each do |element|
          if element.sort.intersection(player2.position).length == 3
            Game.gameover = true;
            player2.player_won = true
            puts "Player 2 won the game!"
            player2.print_screen
            break
          end
        end
      end
      puts Game.count
      Game.count = Game.count + 1
      break
    end
  end

end
        



    


