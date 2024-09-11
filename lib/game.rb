class Game 
    attr_accessor :turns, :player_board, :computer_board, :cells
    def initialize
        @cruiser = Ship.new('Cruiser', 3)
        @submarine = Ship.new('Submarine', 2)
        @c_cruiser = Ship.new('Cruiser', 3)
        @c_submarine = Ship.new('Submarine', 2)
        @player_board = Board.new
        @computer_board = Board.new
        @turn = Turn.new(@player_board ,@computer_board)
    end

    def place_ships
        place_ships_randomly(@c_cruiser)
        place_ships_randomly(@c_submarine)
        p "I have laid out my ships on the grid.\n" +
            "You now need to lay out your two ships.\n" +
"The Cruiser is three units long and the Submarine is two units long.\n"

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
    end

    def start
        puts "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit."
        input = gets.chomp.downcase
        if input == 'p'
            place_ships
        elsif input == 'q'
            p 'Too bad'
        end
    end
        

    def generate_coordinates(start_coordinate, length, orientation)
        row = start_coordinate[0]
        col = start_coordinate[1..0].to_i
        
        if orientation == :horizontal
          (col...(col + length)).map { |c| "#{row}#{c}" }
        else
          (row.ord...(row.ord + length)).map { |r| "#{r.chr}#{col}" }
        end
    end
    
    def place_ships_randomly(ship)
        vertical = @computer_board.columns_array 
        horizontal = @computer_board.rows_array
            max_attempts = 150 
            attempts = 0
           
          
            while attempts < max_attempts
              start_row = @computer_board.rows_array.sample
              start_col = @computer_board.columns_array.sample
              start_coordinate = "#{start_row}#{start_col}"
          
              orientation = [:horizontal, :vertical].sample
          
              coordinates = generate_coordinates(start_coordinate, ship.length, orientation)
          
              if @computer_board.valid_placement?(ship, coordinates)
                @computer_board.place(ship, coordinates)
                return true
              end
              attempts += 1
            end

            false
    end
        
    
    def play_the_game
        @turn.take_turn until
        (@c_cruiser.sunk? && @c_submarine.sunk?) ||(@cruiser.sunk? && @submarine.sunk?)
        p "press enter to continue"
        gets
        return start
    end
    
end