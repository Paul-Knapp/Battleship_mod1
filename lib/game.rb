class Game 
    attr_accessor :turns, :player_board, :computer_board
    def initialize
        @turns = []
        @player_board = Board.new
        @computer_board = Board.new
        cruiser 
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
    end
    
    #computer place ships

    #take a player guess
        #take turn?
        #tell you to try again if you already guessed the coordinate

    #take a guess from a computer

    #show the board with computer ships hidden
end