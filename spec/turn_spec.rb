require 'spec_helper'

RSpec.describe Turn do
    before(:each)
    @turn = Turn.new('A1')
    @board1 = Board.new
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @cell1 = @board1.cells['A1']
    @cell2 = @board1.cells['A2']    

    describe "#initialize" do
        it 'exists' do
            expect(@turn).to be_an_instance_of(Turn)
        end

        it 'has a guess do' do
            expect(@turn.guess).to be('A1')
        end
    end
end