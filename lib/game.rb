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
    p "I have laid out my ships on the grid.\n" +
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
    puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
    input = gets.chomp.downcase
    if input == 'p'
      place_ships
      play_the_game
    elsif input == 'q'
      p 'Too bad'
    end
  end

  def generate_coordinates(start_coordinate, length, orientation)
    row = start_coordinate[0]
    col = start_coordinate[1..-1].to_i

    if orientation == :horizontal
      (col...(col + length)).map { |c| "#{row}#{c}" }
    else
      (row.ord...(row.ord + length)).map { |r| "#{r.chr}#{col}" }
    end
  end

  def place_ships_randomly(ship)
    vertical = @computer_board.columns_array
    horizontal = @computer_board.rows_array
    # changed from 150 to 10 for debugging
    max_attempts = 10
    attempts = 0

    while attempts < max_attempts
      start_row = @computer_board.rows_array.sample
      start_col = @computer_board.columns_array.sample
      start_coordinate = "#{start_row}#{start_col}"

      orientation = %i[horizontal vertical].sample

      coordinates = generate_coordinates(start_coordinate, ship.length, orientation)

      if @computer_board.valid_placement?(ship, coordinates)
        @computer_board.place(ship, coordinates)
        return true
      end
      attempts += 1
    end

    false
  end

<<<<<<< HEAD
  def get_coordinates_for_vertical_placement(ship)
    # setup everything we can right here:
    coordinates_remaining = ship.length
    coordinates = []
    column = %w[1 2 3 4].sample

    # set start row and determine remaining coordinates
    if coordinates_remaining == 3
      row = %w[A B].sample
    elsif coordinates_remaining == 2
      row = %w[A B C].sample
=======
        place_player_ships(@cruiser, 3)
        place_player_ships(@submarine, 2)
       
        play_the_game
    end
    
    def place_player_ships(ship, length)
        loop do
          puts "Enter the squares for the #{ship.name} (#{length} spaces):"
          coordinates = gets.chomp.split
          if @player_board.valid_placement?(ship, coordinates) 
                @player_board.place(ship, coordinates) 
                puts "#{ship.name} placed"
            return
          else
            puts "Invalid placement try again"
          end
        end
>>>>>>> 797426c76efb206c6a9371ff0074e13f3c053dc7
    end

    # store starting coordinate
    coordinates << "#{row}#{column}"

<<<<<<< HEAD
    # increment row for remaining coordinates
    coordinates_remaining -= 1
    coordinates_remaining.times do
      row = (coordinates.last[0].ord + 1).chr
      coordinates << "#{row}#{column}"
=======
    def generate_coordinates(start_coordinate, length, orientation)
        row = start_coordinate[0]
        col = start_coordinate[1..0].to_i
        
        if orientation == :horizontal
          (col...(col + length)).map { |c| "#{row}#{c}" }
        else
          (row.ord...(row.ord + length)).map { |r| "#{r.chr}#{col}" }
        end
>>>>>>> 797426c76efb206c6a9371ff0074e13f3c053dc7
    end
    coordinates # return coordinates array
  end

  def get_coordinates_for_horizontal_placement(ship)
    # setup
    coordinates_remaining = ship.length
    coordinates = []
    row = %w[A B C D].sample

    # set start row and determine remaining coordinates
    if coordinates_remaining == 3
      column = %w[1 2].sample
    elsif coordinates_remaining == 2
      column = %w[1 2 3].sample
    end
<<<<<<< HEAD

    # store starting coordinate
    coordinates << "#{row}#{column}"

    # increment column for remaining coordinates
    coordinates_remaining -= 1
    coordinates_remaining.times do
      column = coordinates.last[1].to_i + 1
      coordinates << "#{row}#{column}"
=======
        
    
    def play_the_game
        @turn.take_turn until
        (@c_cruiser.sunk? && @c_submarine.sunk?) ||(@cruiser.sunk? && @submarine.sunk?)
        p "press enter to continue"
        gets
        return start
>>>>>>> 797426c76efb206c6a9371ff0074e13f3c053dc7
    end
    coordinates # return coordinates array
  end

  def place_ships_randomly_computer_board(ship)
    # setup
    orientation = %w[vertical horizontal].sample
    puts orientation

    if orientation == 'vertical'
      coordinates = get_coordinates_for_vertical_placement(ship)
    elsif orientation == 'horizontal'
      coordinates = get_coordinates_for_horizontal_placement(ship)
    end
    puts coordinates

    # TODO: need to place ship
    return place_ships_randomly_computer_board(ship) until @computer_board.valid_placement?(ship, coordinates)
    @computer_board.place(ship, coordinates)
  end

  def play_the_game
    @turn.take_turn until
    (@c_cruiser.sunk? && @c_submarine.sunk?) || (@cruiser.sunk? && @submarine.sunk?)
    p 'press enter to continue'
    gets
    start
  end
end
