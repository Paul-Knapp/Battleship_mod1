class Game 
    attr_accessor :turns, :player_board, :computer_board
    def initialize
        @turns = []
        @player_board = Board.new
        @computer_board = Board.new
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
        
    #player place ships
    
    #computer place ships

    #take a player guess
        #take turn?
        #tell you to try again if you already guessed the coordinate

    #take a guess from a computer

    #show the board with computer ships hidden
end