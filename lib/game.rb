require 'pry'
class Game
  attr_accessor :turns, :player_board, :computer_board, :cells

  def initialize
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @c_cruiser = Ship.new('Cruiser', 3)
    @c_submarine = Ship.new('Submarine', 2)
    @player_board = Board.new
    @computer_board = Board.new
    @turn = Turn.new(@player_board, @computer_board)
  end

  def place_ships
    place_ships_randomly_computer_board(@c_cruiser)
    place_ships_randomly_computer_board(@c_submarine)
    puts "I have laid out my ships on the grid.\n" +
      "You now need to lay out your two ships.\n" +
      "The Cruiser is three units long and the Submarine is two units long.\n"

    place_player_ship(@cruiser, 3)
    place_player_ship(@submarine, 2)
  end

  def place_player_ship(ship, length)
    loop do
      puts "Enter the squares for the #{ship.name} (#{length} spaces):"
      coordinates = gets.chomp.split
      if @player_board.place(ship, coordinates)
        puts "#{ship.name} placed"
        return
      else
        puts 'Invalid placement try again'
      end
    end
  end

  def start
    # puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    # input = gets.chomp.downcase
    input = 'x'
    until input == 'p' || input == 'q'
      puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
      input = gets.chomp.downcase
        if input == 'p'
          place_ships
          play_the_game
        elsif input == 'q'
          p 'Too bad'
          break
        end
    end
  end

  def get_coordinates_for_vertical_placement(ship)
    coordinates_remaining = ship.length
    coordinates = []
    column = %w[1 2 3 4].sample

    if coordinates_remaining == 3
      row = %w[A B].sample
    elsif coordinates_remaining == 2
      row = %w[A B C].sample
    end

    coordinates << "#{row}#{column}"

    coordinates_remaining -= 1
    coordinates_remaining.times do
      row = (coordinates.last[0].ord + 1).chr
      coordinates << "#{row}#{column}"
    end

    coordinates
  end

  def get_coordinates_for_horizontal_placement(ship)
    coordinates_remaining = ship.length
    coordinates = []
    row = %w[A B C D].sample

    if coordinates_remaining == 3
      column = %w[1 2].sample
    elsif coordinates_remaining == 2
      column = %w[1 2 3].sample
    end

    coordinates << "#{row}#{column}"

    coordinates_remaining -= 1
    coordinates_remaining.times do
      column = coordinates.last[1].to_i + 1
      coordinates << "#{row}#{column}"
    end

    coordinates
  end

  def place_ships_randomly_computer_board(ship)
    orientation = %w[vertical horizontal].sample

    if orientation == 'vertical'
      coordinates = get_coordinates_for_vertical_placement(ship)
    elsif orientation == 'horizontal'
      coordinates = get_coordinates_for_horizontal_placement(ship)
    end

    return place_ships_randomly_computer_board(ship) until @computer_board.valid_placement?(ship, coordinates)
    @computer_board.place(ship, coordinates)
  end

  def play_the_game
    @turn.take_turn until
    (@c_cruiser.sunk? && @c_submarine.sunk?) || (@cruiser.sunk? && @submarine.sunk?)
    if @c_cruiser.sunk? && @c_submarine.sunk?
      puts 'You Won!!'
    elsif @cruiser.sunk? && @submarine.sunk?
      puts 'YOU LOSE!!!!!!!'
    end
    p 'Press p to play again'
    # start
  end
end
