class Board
  attr_reader :cells

  # this is a programmatic way to initialize.
  # avoids hard-coding and makes it easier to change
  # the board size (iteration 4).
  def initialize
    @all_coordinates = []
    @cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        cell_name = "#{letter}#{number}"
        # we could avoid .downcase if we name our
        # cells A1 instead of a1
        @all_coordinates << cell_name 
        @cells[cell_name.downcase.to_sym] = Cell.new(cell_name)
        
      end
    end
  end

  # this was the original initialize.
  # Leaving it here for now.
  # def initialize2
  #   @cells = {
  #     a1: Cell.new('A1'),
  #     a2: Cell.new('A2'),
  #     a3: Cell.new('A3'),
  #     a4: Cell.new('A4'),

  #     b1: Cell.new('B1'),
  #     b2: Cell.new('B2'),
  #     b3: Cell.new('B3'),
  #     b4: Cell.new('B4'),

  #     c1: Cell.new('C1'),
  #     c2: Cell.new('C2'),
  #     c3: Cell.new('C3'),
  #     c4: Cell.new('C4'),

  #     d1: Cell.new('D1'),
  #     d2: Cell.new('D2'),
  #     d3: Cell.new('D3'),
  #     d4: Cell.new('D4')
  #   }
  # end

  def valid_coordinate?(input_coordinate)
    @cells.each do |cell|
      cell_coordinate = cell[1].coordinate

      return true if cell_coordinate == input_coordinate
    end
    false # did not find a valid coordinate
  end

  def get_columns(coordinates)
    # accepts an array of coordinates
    # returns an array of unique columns ('1', '2', etc..)
    columns = coordinates.map { |coordinate| coordinate[1] }
    columns.uniq
  end

  def get_rows(coordinates)
    # accepts an array of coordinates
    # returns an array of unique rows ('A', 'B', etc..)
    rows = coordinates.map { |coordinate| coordinate[0] }
    rows.uniq
  end

  def diagonal?(coordinates)
    num_rows = get_rows(coordinates).length
    num_columns = get_columns(coordinates).length

    if num_rows == 1 || num_columns == 1
      false
    else
      true
    end
  end

  def not_consecutive?(ship, coordinates)
    return true if coordinates.size <= 1
    columns = get_columns(coordinates)
    rows = get_rows(coordinates)
    if rows.uniq.size == 1
      # the above row skips the below code if the coordinates share a row
      !columns.map(&:to_i).each_cons(2).all? { |a,b| b == a + 1}
      # the &:to_i converts converts the value to a callable object and then turns the symbol into an integer.
      #looks at all columns and determines if they column b is next to a
      #uses the bang operator because we are trying to return a true if consecutive is false.
    elsif columns.uniq.size == 1
      !rows.map(&:to_i).each_cons(2).all? { |a,b| b.ord == a.ord + 1}
    else
      true
    end

  end

  def incorrect_length?(ship, coordinates)
    num_rows = get_rows(coordinates).length
    num_columns = get_columns(coordinates).length
      if num_columns > ship.length || num_rows > ship.length 
        true
      else
        false
      end
  end

  def valid_placement?(ship, coordinates)
    if diagonal?(coordinates)  || not_consecutive?(ship, coordinates) || incorrect_length?(ship, coordinates)
      false
    else
      true
    end
  end
end
