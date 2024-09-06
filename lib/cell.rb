class Cell
    attr_reader :coordinate, :ship
    def initialize(coordinate)
        @coordinate = coordinate
        ships = []
        ship = ships[0]
    end

    def place_ship(type)
        ships << type
    end

    def empty?
        ships.length == 0
    end
end