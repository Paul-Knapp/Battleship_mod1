require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @ship1 = Ship.new("Cruiser", 3 )
    end

    it 'exists' do 
        expect(@ship1).to be_an_instance_of (Ship)
    end
end