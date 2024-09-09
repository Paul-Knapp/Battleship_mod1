class Cell
    attr_reader :coordinate
    attr_accessor :ship
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
    end

    def fired_upon?
        @fired_upon
    end

    def place_ship(type)
        @ship = type
    end

    def empty?
        @ship == nil
    end

    def fire_upon
        @fired_upon = true
        @ship.hit if @ship
    end

    def render(on_off = false)
        if @ship == nil && @fired_upon == true
            "M"
        elsif @ship == nil && @fired_upon == false
            "."
        elsif @ship != nil && @fired_upon == false
            if on_off == false
                "."
            else
                "S"
            end
        elsif @ship != nil && @fired_upon == true && @ship.sunk? == false
                "H"
        elsif @ship.sunk? == true
                "X"
        end
    end
end