class Turn
  attr_reader :shot, :board, :user_result, :computer_result
  attr_writer :shots_fired_board1, :shots_fired_board2

  @@shots_fired_board1 = []
  @@shots_fired_board2 = []

  def self.shots_fired_board1
    @@shots_fired_board1
  end

  def self.shots_fired_board2
    @@shots_fired_board2
  end

  def initialize(board1, board2)
    @board1 = board1
    @board2 = board2
    @turn_number = 0
  end

  def print_boards(on_off = false)
    puts 'Player Board:'
    @board1.render(true)
    puts

    puts 'Computer Board:'
    @board2.render(on_off)
    puts
  end

  def take_turn
    @turn_number += 1
    puts "\n" + '*' * 7 + " turn number: #{@turn_number} " + '*' * 7 + "\n"

    print_boards
    computer_shot
    user_shot
    result
    print_boards
    @turn_number
  end

  def random_shot
    valid_unfired_coordinates = @board1.cells.keys - @@shots_fired_board1
    valid_unfired_coordinates.sample
  end

  def computer_shot
    target = random_shot

    @board1.cells[target].fire_upon
    @@shots_fired_board1 << target
    report = damage_report(@board1, target)

    @computer_result = "#{target}: " + damage_report(@board1, target)
  end

  def valid_target_board2?(target)
    return false unless @board2.valid_coordinate?(target)

    return true unless @board2.cells[target].fired_upon?

    puts 'you already shot there.'
    false
  end

  def valid_target_board1?(target)
    return false unless @board1.valid_coordinate?(target)

    return true unless @board1.cells[target].fired_upon?

    puts 'you already shot there.'
    false
  end

  def user_shot
    print 'enter target: '
    target = gets.chomp

    unless valid_target_board2?(target)
      puts 'invalid target'
      return user_shot
    end

    @board2.cells[target].fire_upon && @@shots_fired_board2 << target

    @user_result = "#{target}: " + damage_report(@board2, target)
  end

  def damage_report(board, target)
    ship = board.cells[target].ship

    if ship && ship.sunk?
      "sunk #{ship.name}"
    elsif ship
      'hit'
    else
      'miss'
    end
  end

  def result
    puts "User result: #{@user_result}"
    puts "Computer result: #{@computer_result}"
    puts
  end
end
