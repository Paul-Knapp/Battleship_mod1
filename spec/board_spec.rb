require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board1 = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Cruiser', 2)
  end

  describe '#initialize' do
    it 'is a Board' do
      expect(@board1).to be_an_instance_of(Board)
    end
    it 'has 16 cells' do
      expect(@board1.cells.length).to eq (16)
      expect(@board1.cells[:a1]).to be_an_instance_of (Cell)
    end
  end

  describe '#valid coordinate' do
    it 'can tell a valid coordinate'
      expect(@board1.valid_coordinate?('A1')).to eq (true)
      expect(@board1.valid_coordinate?('D4')).to eq (true)
  end
    it 'can tell an invalid coordinate' do
      expect(@board1.valid_coordinate?('D7')).to eq (false)
      expect(@board1.valid_coordinate?('D15')).to eq (false)
    end

  describe '#it can determine valid placement' do
    it 'can tell valid placement' do
      expect(@board1.valid_placement?(cruiser, ['A1','A2','A3'])).to eq (true)
      expect(@board1.valid_placement?(submarine, ['B1','B2'])).to eq (true)
    end

    it 'can determine overlapping placement' do
      expect(@board1.valid_placement?(cruiser, ['A1','A2','A3'])).to eq (true)
      expect(@board1.valid_placement?(submarine, ['A1','A2'])).to eq (false)
    end

    it 'can determine diagonal placement' do
      expect(@board1.valid_placement?(cruiser, ['A1','B2','C3'])).to eq (false)
      expect(@board1.valid_placement?(submarine, ['B3','A2'])).to eq (false)
    end

    it 'can determine non-consecutive placement' do
      expect(@board1.valid_placement?(cruiser, ['A1','A3','A4'])).to eq (false)
      expect(@board1.valid_placement?(submarine, ['C4','B2'])).to eq (false)
    end

    it 'can determine if placement isnt on the board' do
      expect(@board1.valid_placement?(cruiser, ['A5','A6','A7'])).to eq (true)
      expect(@board1.valid_placement?(submarine, ['B12','B13'])).to eq (true)
    end
  end
end
