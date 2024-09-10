class Turn
  attr_reader :shot, :board

  def initialize(shot, board1, board2)
    @shot = shot
    @board1 = board1 # User
    @board2 = board2 # Computer
  end

  def take_turn
    # Computer does not fire on the same spot twice
    @@shots_fired = []

    # User board is displayed showing hits, misses, sunken ships, and ships
    @board1.render(true)

    # Computer board is displayed showing hits, misses, and sunken ships
    @board2.render(true)
  end

  def random_shot
    # Computer chooses a random shot
  end

  def user_shot
    # User can choose a valid coordinate to fire on
    # Entering invalid coordinate prompts user to enter valid coordinate
    # User is informed when they have already fired on a coordinate
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

