require 'spec_helper'

RSpec.describe Turn do
    before(:each) do
    @turn = Turn.new('A1')
    @board1 = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @cell1 = @board1.cells['A1']
    @cell2 = @board1.cells['A2']   
    end

    describe "#initialize" do
        it 'exists' do
            expect(@turn).to be_an_instance_of(Turn)
        end

        it 'has a guess do' do
            expect(@turn.shot).to eq('A1')
        end
    end

    describe '#register shots' do
        it 'can show a hit' do
            @board1.place(@cruiser, %w[A1 A2 A3])
            expect(@turn.is_a_hit).to eq(true)
        end
    end
end