require 'spec_helper'
RSpec.describe Game do
    before(:each) do
        game = Game.new
    end
    it "#exists" do
        expect(game).to be_an_instance_of(Game)
    end

    #it has a board

    #it can take a player turn

    #it can take a computer turn

    # # it knows results

    #it knows that you have already shot at a coordinate

    #it displays results with every shot taken




end