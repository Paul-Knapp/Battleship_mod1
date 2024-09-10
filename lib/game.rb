class Game 
    attr_accessor :turns, :player_board, :computer_board
    def initialize
        @turns = []
        @player_board = Board.new
        @computer_board = Board.new
        @cruiser = Ship.new('Cruiser', 3)
        @submarine = Ship.new('Submarine', 2)
    end

    def start
        puts "Welcome to BATTLESHIP\n
            Enter p to play. Enter q to quit."
        input = gets
        if input == ('q')
            self.place_ships
        elsif input == ('p')
        end
    end
        
    def place_ships
        #computer places ships
        p "I have laid out my ships on the grid.\n
            You now need to lay out your two ships.\n
The Cruiser is three units long and the Submarine is two units long.\n
        +#{@player_board.render}
        Enter the squares for the Cruiser (3 spaces):"
        @player_board.place_ship(cruiser[gets])
        p "Enter the squares for the Submarine (2 spaces):"
       until @player_board.place_ship(submarine[gets]) == true 
        @player_board.place_ship(submarine[gets]) == true
       else
       end
    end
    
    def take_turns

    end
        
    def end_game?
        #end game once one sides ships are all sunk
    end

    #take a guess from a computer

    #show the board with computer ships hidden
end