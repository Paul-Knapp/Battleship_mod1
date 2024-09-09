require './lib/cell'

class Board
  attr_accessor :cells

  def initialize(grid_size = 4)
    @grid_size = grid_size
    @max_row_ordinal = 'A'.ord + @grid_size - 1

    @occupied_coordinates = []
    @cells = {}

    rows_array.each do |row|
      columns_array.each do |column|
        cell_key = "#{row}#{column}"
        @cells[cell_key] = Cell.new(cell_key)
      end
    end
  end

  def valid_coordinate?(*input_coordinates)
    input_coordinates.flatten.all? do |coordinate|
       if @cells.keys.include?(coordinate) == true
        true
       else
        false
       end
      end
  end

  def get_columns(coordinates)
    coordinates.map { |coordinate| coordinate[1] }.uniq
  end

  def get_rows(coordinates)
    coordinates.map { |coordinate| coordinate[0] }.uniq
  end

  def horizontal?(coordinates)
    get_rows(coordinates).length == 1
  end

  def vertical?(coordinates)
    get_columns(coordinates).length == 1
  end

  def diagonal?(coordinates)
    horizontal?(coordinates) || vertical?(coordinates) ? false : true
  end

  def not_consecutive?(ship, coordinates)
    return true if coordinates.size <= 1

    columns = get_columns(coordinates)
    rows = get_rows(coordinates)

    if horizontal?(coordinates)
      !columns.map(&:to_i).each_cons(2).all? { |a, b| b == a + 1 }
    elsif vertical?(coordinates)
      !rows.map(&:ord).each_cons(2).all? { |a, b| b == a + 1 }
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
    if diagonal?(coordinates) || not_consecutive?(ship, coordinates) || incorrect_length?(ship, coordinates) || overlapping_placement?(coordinates)
      false
    else
      true
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == true
      coordinates.each do |coordinate|
        @occupied_coordinates << coordinate
      end
  
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    else 
      false
    end
  end

  def columns_array
    (1..@grid_size).to_a
  end

  def rows_array
    ('A'..@max_row_ordinal.chr).to_a
  end

  def render_header
    print ' '
    puts columns_array.join(' ')
  end

  def render_row(row, on_off)
    grid = []

    columns_array.each do |position|
      cell_key = "#{row}#{position}"
      grid << @cells[cell_key].render(on_off)
    end
    print "#{row} "
    puts grid.join(' ')
  end

  def render(on_off = false)
    render_header

    rows_array.each do |row|
      render_row(row, on_off)
    end
  end
end
