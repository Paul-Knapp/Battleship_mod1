require './lib/cell'

class Board
  attr_accessor :cells

  def initialize(grid_size = 4)
    @grid_size = grid_size
    @max_row_ordinal = 'A'.ord + @grid_size - 1

    @occupied_coordinates = []
    @cells = {}

    ('A'..@max_row_ordinal.chr).each do |row|
      (1..@grid_size).each do |column|
        cell_key = "#{row}#{column}"
        @cells[cell_key] = Cell.new(cell_key)
      end
    end
  end

  def valid_coordinate?(input_coordinate)
    @cells[input_coordinate] ? true : false
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

    if rows.size == 1 # horizontal placement
      !columns.map(&:to_i).each_cons(2).all? { |a, b| b == a + 1 }
    elsif columns.size == 1 # vertical placement
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

    coordinates.each do |coordinate|
      @occupied_coordinates << coordinate
    end

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def render_header
    # TODO: render_header
  end

  def render_row(row, on_off)
    grid = []
    (1..@grid_size).each do |position|
      cell_key = "#{row}#{position}"
      grid << @cells[cell_key].render(on_off)
    end
    puts grid.join(' ')
  end

  def render(on_off = false)
    render_header

    range = 'A'..@max_row_ordinal.chr
    range.to_a.each do |row|
      render_row(row, on_off)
    end
  end
end
