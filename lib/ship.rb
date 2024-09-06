class Ship
  attr_reader :name, :length, :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
    @sunk = false
  end

  def hit
    @health -= 1
    @sunk = true if @health == 0

    @health
  end

  def sunk?
    @sunk
  end
end
