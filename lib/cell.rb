class Cell
    attr_reader :coordinate, :ship, :fired_upon?
    def initialize(coordinate)
        @coordinate = coordinate
        ships = []
        ship = ships[0]
        fired_upon? = false
    end

    def place_ship(type)
        ships << type
    end

    def empty?
        ships.length == 0
    end

    def fire_upon
        fired_upon? = true
    end
end