class Board
  attr_accessor :cells, :occupied_coordinates

  def initialize
    @cells = {}
    ('A'..'D').each do |letter|
      (1..4).each do |number|
        cell_name = "#{letter}#{number}"
        # we could avoid .downcase if we name our
        # cells A1 instead of a1
        @cells[cell_name.downcase.to_sym] = Cell.new(cell_name)
      end
    end
    @cells = cells
    @occupied_coordinates = []
  end

  def valid_coordinate?(input_coordinate)
    @cells.each do |cell|
      cell_coordinate = cell[1].coordinate

      return true if cell_coordinate == input_coordinate
    end
    false
  end

  def get_columns(coordinates)
    columns = coordinates.map { |coordinate| coordinate[1] }
    columns.uniq
  end

  def get_rows(coordinates)
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

    if rows.uniq.size == 1 # horizontal placement
      !columns.map(&:to_i).each_cons(2).all? { |a, b| b == a + 1 }
    elsif columns.uniq.size == 1 # vertical placement
      !rows.map(&:to_i).each_cons(2).all? { |a, b| b.ord == a.ord + 1 }
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

  def overlapping_placement?(coordinates)
    coordinates_to_check = @occupied_coordinates & coordinates
    if coordinates_to_check.any?
      true
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    if diagonal?(coordinates) || not_consecutive?(ship, coordinates) ||
       incorrect_length?(ship, coordinates) || overlapping_placement?(coordinates)
      false
    else
      true
    end
  end

  def place(ship, coordinates)
    return false unless valid_placement?(ship, coordinates)

    lowercased_coordinates = coordinates.map(&:downcase)
    symbol_coordinates = lowercased_coordinates.map(&:to_sym)

    coordinates.each do |coordinate|
      @occupied_coordinates << coordinate
    end

    symbol_coordinates.each do |symbol_coordinate|
      @cells[symbol_coordinate].place_ship(ship)
      # @occupied_coordinates << symbol_coordinate
    end
  end
end
