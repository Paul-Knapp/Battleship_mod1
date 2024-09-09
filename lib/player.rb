class Player
  attr_reader :type,
              def initialize(type, name, num_ships = 2)
                @type = type # computer or human
                @name = name
                @num_ships = 2
                @board = Board.new
              end
end
