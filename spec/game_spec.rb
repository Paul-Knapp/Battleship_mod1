require 'spec_helper'
RSpec.describe Game do
  before(:each) do
    @game = Game.new
    @board_1 = Board.new
  end

  it '#exists' do
    expect(@game).to be_an_instance_of(Game)
  end

  it '#has both boards' do
    expect(@game.player_board).to be_an_instance_of(Board)
    expect(@game.computer_board).to be_an_instance_of(Board)
  end

end