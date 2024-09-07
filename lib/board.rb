class Board
  attr_reader :cells
  def initialize
    @cells = {
      a1: Cell.new('A1'),
      a2: Cell.new('A2'),
      a3: Cell.new('A3'),
      a4: Cell.new('A4'),

      b1: Cell.new('B1'),
      b2: Cell.new('B2'),
      b3: Cell.new('B3'),
      b4: Cell.new('B4'),

      c1: Cell.new('C1'),
      c2: Cell.new('C2'),
      c3: Cell.new('C3'),
      c4: Cell.new('C4'),

      d1: Cell.new('D1'),
      d2: Cell.new('D2'),
      d3: Cell.new('D3'),
      d4: Cell.new('D4')}
  end

  def valid_coordinate?(coordinate)
    @cells.find do |name,cell|
      binding.pry
      name.upcase
    end
  end
end
