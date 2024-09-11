require 'spec_helper'

RSpec.describe Turn do
  before(:each) do
    @board1 = Board.new
    @board2 = Board.new
    @turn = Turn.new(@board1, @board2)

    @p1s1 = Ship.new('Cruiser', 3)
    @p1s2 = Ship.new('Submarine', 2)
    @p2s1 = Ship.new('Cruiser', 3)
    @p2s2 = Ship.new('Submarine', 2)

    @board1.place(@p1s1, %w[A1 A2 A3])
    @board1.place(@p1s2, %w[B1 B2])
    @board2.place(@p2s1, %w[C1 C2 C3])
    @board2.place(@p2s2, %w[D3 D4])
  end

  describe 'board1:' do
    it 'has placed a Cruiser in the correct location' do
      expect(@board1.cells['A1'].ship).to eq(@p1s1)
      expect(@board1.cells['A2'].ship).to eq(@p1s1)
      expect(@board1.cells['A3'].ship).to eq(@p1s1)
    end
    it 'has placed a Submarine in the correct location' do
      expect(@board1.cells['B1'].ship).to eq(@p1s2)
      expect(@board1.cells['B2'].ship).to eq(@p1s2)
    end
  end

  describe 'board2:' do
    it 'has placed a Cruiser in the correct location' do
      expect(@board2.cells['C1'].ship).to eq(@p2s1)
      expect(@board2.cells['C2'].ship).to eq(@p2s1)
      expect(@board2.cells['C3'].ship).to eq(@p2s1)
    end
    it 'has placed a Submarine in the correct location' do
      expect(@board2.cells['D3'].ship).to eq(@p2s2)
      expect(@board2.cells['D4'].ship).to eq(@p2s2)
    end
  end

  describe '#computer_shot' do
    it 'can take a valid shot and update the results' do
      initial_shots_count = Turn.shots_fired_board1.count
      puts "Initial shots count: #{initial_shots_count}"

      @turn.computer_shot

      after_shots_count = Turn.shots_fired_board1.count
      puts "Shots count after computer_shot: #{after_shots_count}"

      expect(after_shots_count).to eq(initial_shots_count + 1)
      expect(@turn.computer_result).to be_a(String)

      target = Turn.shots_fired_board1.last
      expect(@board1.cells[target].fired_upon?).to be true
    end
  end

  describe '#valid_target_board2?' do
    it 'returns false for invalid coordinates' do
      expect(@turn.valid_target_board2?('Z10')).to be false
    end

    it 'returns false for coordinates already fired upon' do
      @turn.computer_shot # Let the computer fire on a target
      target = Turn.shots_fired_board2.last
      expect(@turn.valid_target_board2?(target)).to be false
    end

    it 'returns true for valid coordinates' do
      expect(@turn.valid_target_board2?('A1')).to be true
    end
  end

  describe '#random_shot' do
    it 'returns a valid random shot from available shots' do
      available_shots = @board1.cells.keys

      # Firing shots to remove them from available shots
      5.times do
        shot = @turn.random_shot
        expect(available_shots).to include(shot)
        Turn.shots_fired_board1 << shot
      end

      # Check that subsequent calls to random_shot do not include shots already fired
      5.times do
        shot = @turn.random_shot
        expect(Turn.shots_fired_board1).not_to include(shot)
      end
    end
  end

  describe '#initialize' do
    it 'exists' do
      expect(@turn).to be_an_instance_of(Turn)
    end
  end
end
