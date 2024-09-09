require 'spec_helper'

RSpec.describe Board do
  before(:each) do
    @board1 = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @cell1 = @board1.cells['A1']
    @cell2 = @board1.cells['A2']
  end

  describe '#initialize' do
    it 'is a Board' do
      expect(@board1).to be_an_instance_of(Board)
      @board1.place(@submarine, %w[A1 B1])
    end

    it 'has 16 cells' do
      expect(@board1.cells.length).to eq(16)
      expect(@board1.cells['A1']).to be_an_instance_of(Cell)
    end
  end

  describe '#valid coordinate' do
    it 'can tell a valid coordinate' do
      expect(@board1.valid_coordinate?('A1')).to eq(true)
      expect(@board1.valid_coordinate?('D4')).to eq(true)
    end
    it 'can tell an invalid coordinate' do
      expect(@board1.valid_coordinate?('D7')).to eq(false)
      expect(@board1.valid_coordinate?('D15')).to eq(false)
    end
  end

  describe '#it can determine valid placement' do
    it 'can tell valid placement' do
      expect(@board1.valid_placement?(@cruiser, %w[A1 A2 A3])).to eq(true)
      expect(@board1.valid_placement?(@submarine, %w[B1 B2])).to eq(true)
    end

    it 'can determine diagonal placement' do
      expect(@board1.valid_placement?(@cruiser, %w[A1 B2 C3])).to eq(false)
      expect(@board1.valid_placement?(@submarine, %w[B3 A2])).to eq(false)
    end

    it 'can determine non-consecutive placement' do
      expect(@board1.valid_placement?(@cruiser, %w[A1 A3 A4])).to eq(false)
      expect(@board1.valid_placement?(@submarine, %w[C4 B2])).to eq(false)
    end

    # it 'can determine if placement isnt on the board' do
    #   expect(@board1.valid_placement?(@cruiser, %w[A5 A6 A7])).to eq(false)
    #   expect(@board1.valid_placement?(@submarine, %w[B12 B13])).to eq(false)
    # end

    it 'can determine if the placement is the wrong length' do
      expect(@board1.valid_placement?(@cruiser, %w[A1 A2 A3 A4])).to be(false)
      expect(@board1.valid_placement?(@submarine, %w[A1 A2 A3])).to be(false)
    end
  end

  describe '#it can place ships' do
    it 'can place a ship on the board' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      expect(@board1.cells['A1'].ship).to be_an_instance_of(Ship)
      expect(@board1.cells['A2'].ship).to be_an_instance_of(Ship)
      expect(@board1.cells['A3'].ship).to eq(@cruiser)
    end

    it 'can determine overlapping placement' do
      expect(@board1.valid_placement?(@cruiser, %w[A1 A2 A3])).to eq(true)
      @board1.place(@cruiser, %w[A1 A2 A3])
      expect(@board1.valid_placement?(@submarine, %w[A1 A2])).to eq(false)
      @board1.place(@submarine, %w[C1 C2])
    end
  end

  describe '#it can render the board' do
    it 'can render the header' do
      expect { @board1.render_header }.to output(" 1 2 3 4\n").to_stdout
    end

    it 'can render rows' do
      expect { @board1.render_row('A', true) }.to output("A . . . .\n").to_stdout
      expect { @board1.render_row('A', false) }.to output("A . . . .\n").to_stdout
    end

    it 'can render ships' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      expect { @board1.render_row('A', true) }.to output("A S S S .\n").to_stdout
      @board1.place(@submarine, %w[B1 C1])
      expect { @board1.render_row('B', true) }.to output("B S . . .\n").to_stdout
      expect { @board1.render_row('C', true) }.to output("C S . . .\n").to_stdout
    end

    it 'can hide ships' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      expect { @board1.render_row('A', false) }.to output("A . . . .\n").to_stdout
      expect { @board1.render_row('A', false) }.to_not output(". . . . .\n").to_stdout
      @board1.place(@submarine, %w[B1 C1])
      expect { @board1.render_row('B', false) }.to output("B . . . .\n").to_stdout
      expect { @board1.render_row('C', false) }.to output("C . . . .\n").to_stdout
    end

    it 'can render a miss' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      @board1.cells['A4'].fire_upon
      expect { @board1.render_row('A', false) }.to output("A . . . M\n").to_stdout
      @board1.place(@submarine, %w[B1 C1])
      @board1.cells['B2'].fire_upon
      @board1.cells['C2'].fire_upon
      expect { @board1.render_row('B', false) }.to output("B . M . .\n").to_stdout
      expect { @board1.render_row('C', false) }.to output("C . M . .\n").to_stdout
    end

    it 'can render a hit' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      @board1.cells['A1'].fire_upon
      expect { @board1.render_row('A', false) }.to output("A H . . .\n").to_stdout
      @board1.place(@submarine, %w[B1 C1])
      @board1.cells['B1'].fire_upon
      expect { @board1.render_row('B', false) }.to output("B H . . .\n").to_stdout
    end

    it 'can render a sink' do
      @board1.place(@cruiser, %w[A1 A2 A3])
      @board1.cells['A1'].fire_upon
      @board1.cells['A2'].fire_upon
      @board1.cells['A3'].fire_upon
      expect { @board1.render_row('A', false) }.to output("A X X X .\n").to_stdout
    end
  end
end
