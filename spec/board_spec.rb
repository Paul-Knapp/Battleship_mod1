require 'spec_helper'

RSpec.describe Board do
  it 'is a Board' do
    expect(Board.new).to be_an_instance_of(Board)
  end

  before(:each) do
    @board1 = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Cruiser', 2)
  end

  describe '#initialize' do
    it 'has 16 cells' do
      expect(@board1.cells.length).to eq(16)
      expect(@board1.cells[:a1]).to be_an_instance_of(Cell)
    end
  end
end
