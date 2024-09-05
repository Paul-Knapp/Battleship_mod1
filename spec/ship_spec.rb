require 'rspec'
require './lib/ship'

RSpec.describe Ship do
    before(:each) do
        @ship1 = Ship.new("Cruiser", 3 )
    end
end