class Turn
  attr_reader :shot, :board

  @@shots_fired_board1 = []
  @@shots_fired_board2 = []

  def self.shots_fired_board1
    @@shots_fired_board1
  end

  def self.shots_fired_board2
    @@shots_fired_board2
  end

  def initialize(shot, board1, board2)
    @shot = shot
    @board1 = board1 # User
    @board2 = board2 # Computer
  end

  def take_turn
    # User board is displayed showing hits, misses, sunken ships, and ships - done
    @board1.render(true)

    # Computer board is displayed showing hits, misses, and sunken ships - done
    @board2.render(true)
  end

  def random_shot
    (@board1.cells.keys - @@shots_fired_board1).sample
  end

  def computer_shot
    # Computer chooses a random shot - done
    # Computer does not fire on the same spot twice - done
    target = random_shot
    @board1.cells[target].fire_upon
    @@shots_fired_board1 << target
    target
  end

  def valid_target?(target)
    if @board2.cells[target].fired_upon?
      puts 'you already shot there.'
      return false
    end
    @board2.valid_coordinate?(target)
  end

  def user_shot
    # User can choose a valid coordinate to fire on - done
    print 'enter target: '
    target = gets.chomp

    # here

    unless valid_target?(target)
      puts 'invalid target'
      user_shot
    end

    @board2.cells[target].fire_upon && @@shots_fired_board2 << target

    # Entering invalid coordinate prompts user to enter valid coordinate - done
    # User is informed when they have already fired on a coordinate - done
  end

  def damage_report
    # Both computer and player shots are reported as a hit, sink, or miss
    # Board is updated after a turn
  end

  def is_a_hit
    !@board.cells[shot].ship.nil?
  end

  def feedback
    if is_a_hit
      "your shot on #{shot} was a hit"
    elsif is_a_hit
      "your shot on #{shot} was a miss"
    end
  end
end

