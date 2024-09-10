class Game 
    attr_accessor :turns, :player_board, :computer_board
    def initialize
        @turns = []
        @cruiser = Ship.new('Cruiser', 3)
        @submarine = Ship.new('Submarine', 2)
        turn = Turn.new
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
        
    def place_ships
        place_ships_randomly(@cruiser)
        place_ships_randomly(@submarine)
        p "I have laid out my ships on the grid.\n" +
            "You now need to lay out your two ships.\n" +
"The Cruiser is three units long and the Submarine is two units long.\n"
        +{@turns[0].render}
        Enter the squares for the Cruiser (3 spaces):"
        @turns[0].board2.place_ship(cruiser, [gets.chomp.split])
        p "Enter the squares for the Submarine (2 spaces):"
       until @player_board.place_ship(submarine[gets]) == true 
        @player_board.place_ship(submarine[gets.chomp.split]) == true
       else
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
        turns[0].board2.columns_array = verticle
        turns[0].board2.rows_array = horizontal(ship)
            attempts = 0
            max_attempts = 100
          
            while attempts < max_attempts
              start_row = rows_array.sample
              start_col = columns_array.sample
              start_coordinate = "#{start_row}#{start_col}"
          
              orientation = [:horizontal, :vertical].sample
          
              coordinates = generate_coordinates(start_coordinate, ship.length, orientation)
          
              if valid_placement?(ship, coordinates)
                place(ship, coordinates)
                return true
              end
              attempts += 1
            end
            false 
        end
    end
        
    

    #take a guess from a computer

    #show the board with computer ships hidden
end