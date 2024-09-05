require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @ship1 = Ship.new('Cruiser', 3 )
    end

    it 'exists' do 
        expect(@ship1).to be_an_instance_of (Ship)
    end

    it 'has attributes' do 
        it 'has a name' do
            expect(@ship1.name).to eq ('Cruiser')
        end

        it 'has a length' do
            expect(@ship1.length).to eq (3)
        end

        it 'has health' do
            expect(@ship1.health).to eq (3)
            expect(@ship1.health).to eq (@ship.length)
        end
    end
end