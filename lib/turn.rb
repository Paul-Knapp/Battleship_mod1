class Turn
  attr_reader :shot, :board

  @@shots_fired = []

  def self.shots_fired
    @@shots_fired
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
    (@board1.cells.keys - @@shots_fired).sample
  end

  def computer_shot
    # Computer chooses a random shot - done
    # Computer does not fire on the same spot twice - done
    target = random_shot
    @board1.cells[target].fire_upon
    @@shots_fired << target
    target
  end

  def valid_target?(target)
    @board2.valid_coordinate?(target)
  end

  def user_shot
    # User can choose a valid coordinate to fire on
    print 'enter target: '
    target = gets.chomp
    if valid_target?(target)
      puts 'target acquired'
    else
      puts 'invalid target'
      user_shot
    end
    # Entering invalid coordinate prompts user to enter valid coordinate
    # User is informed when they have already fired on a coordinate
  end

  def damage_report
    all_targets = board1.place(p1s1, %w[A1 A2 A3])
    board1.place(p1s2, %w[B1 B2])
    board2.place(p2s1, %w[A1 A2 A3])
    board2.place(p2s2, %w[D1 D2])

    turn = Turn.new('A1', board1, board2)
    turn.take_turn

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

