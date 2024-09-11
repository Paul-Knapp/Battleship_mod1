class Turn
  attr_reader :shot, :board, :user_result, :computer_result

  @@shots_fired_board1 = []
  @@shots_fired_board2 = []

  def self.shots_fired_board1
    @@shots_fired_board1
  end

  def self.shots_fired_board2
    @@shots_fired_board2
  end

  def initialize(board1, board2)
    @board1 = board1 # User
    @board2 = board2 # Computer
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
    # system('clear') # Clear the terminal
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
    # Computer does not fire on the same spot twice - done
    valid_unfired_coordinates = @board1.cells.keys - @@shots_fired_board1
    valid_unfired_coordinates.sample
  end

  def computer_shot
    # Computer chooses a random shot - done
    target = random_shot

    @board1.cells[target].fire_upon
    @@shots_fired_board1 << target
    report = damage_report(@board1, target)

    @computer_result = "#{target}: " + damage_report(@board1, target)
  end

  def valid_target_board2?(target) # computer board
    return false unless @board2.valid_coordinate?(target)

    # Computer is informed when they have already fired on a coordinate - done
    return true unless @board2.cells[target].fired_upon?

    puts 'you already shot there.'
    false
  end

  def valid_target_board1?(target) # user board
    return false unless @board1.valid_coordinate?(target)

    # User is informed when they have already fired on a coordinate - done
    return true unless @board1.cells[target].fired_upon?

    puts 'you already shot there.'
    false
  end

  def user_shot
    print 'enter target: '
    target = gets.chomp

    # User can choose a valid coordinate to fire on - done
    unless valid_target_board2?(target)
      puts 'invalid target'
      # Entering invalid coordinate prompts user to enter valid coordinate - done
      return user_shot
    end

    # user will fire on board2 and update @@shots_fired_board2
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
