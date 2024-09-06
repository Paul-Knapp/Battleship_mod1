class Cell
    
    def initialize(coordinate)
        @coordinate = coordinate
        ships = []
        ship = ships[0]
    end

    def place_ship(type)
        ships << type
    end
end