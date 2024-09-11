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
    @ship.nil?
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @ship
  end

  def rgb(input)
    if input == 'r'
      "\e[31m"
    elsif input == 'g'
      "\e[32m"
    elsif input == 'x' # stop code
      "\e[0m"
    elsif input == 'b'
      "\e[34m"
    end
  end

  def render(on_off = false)
    if @ship.nil? && @fired_upon == true
      'M'
    elsif @ship.nil? && @fired_upon == false
      rgb('b') + '.' + rgb('x')
    elsif !@ship.nil? && @fired_upon == false
      if on_off == false
        rgb('b') + '.' + rgb('x')
      else
        rgb('g') + 'S' + rgb('x')
      end
    elsif !@ship.nil? && @fired_upon == true && @ship.sunk? == false
      rgb('r') + 'H' + rgb('x')
    elsif @ship.sunk? == true
      'X'
    end
  end
end

