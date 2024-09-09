class Turn
    attr_reader :shot, :board

    def initialize(shot, board)
        @shot = shot
        @board = board
    end

    def is_a_hit
        @board.cells[shot].ship != nil
    end

    def feedback
        if is_a_hit == true
            "your shot on #{shot} was a hit"
        elsif is_a_hit = false
             "your shot on #{shot} was a miss"
        end
    end
end