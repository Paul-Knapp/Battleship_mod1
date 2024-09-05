require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new('Cruiser', 3 )
    end

    it 'exists' do 
        expect(@cruiser).to be_an_instance_of (Ship)
    
            it 'has attributes' do 
                it 'has a name' do
                    expect(@cruiser.name).to eq ('Cruiser')
                end

                it 'has a length' do
                    expect(@cruiser.length).to eq (3)
                end

                it 'has health' do
                    expect(@cruiser.health).to eq (3)
                    expect(@cruiser.health).to eq (@ship.length)
                end

                it 'isnt sunk' do
                    expect(@cruiser.sunk).to eq (false)
                end
            end
    end

    it 'can be hit' do
        @cruiser.hit
        expect(@cruiser.health).to eq (2)
    end

    it 'can be sunk' do
        @cruiser.hit
        expect(@cruiser.health).to eq (2)
        expect(@cruiser.sunk).to eq (false)
        @cruiser.hit
        expect(@cruiser.health).to eq (1)
        expect(@cruiser.sunk).to eq (false)
        @cruiser.hit
        expect(@cruiser.health).to eq (0)
        expect(@cruiser.sunk).to eq (true)
    end
end