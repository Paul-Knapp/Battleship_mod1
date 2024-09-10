require 'spec_helper'
RSpec.describe Game do
    before(:each) do
        @game = Game.new
        @board_1 = Board.new
    end

    it "#exists" do
        expect(game).to be_an_instance_of(Game)
    end

    it "#has both boards" do
        expect(@game.player_board).to be_an_instance_of(Board)
        expect(@game.computer_board).to be_an_instance_of(Board)
    end

    it "#can start a new game" do
        expect{game.start}.to output(Welcome to BATTLESHIP\n
        Enter p to play. Enter q to quit.).to_stdout
    end

    

        # # it knows results

        #it knows that you have already shot at a coordinate

         #it displays results with every shot taken
    
    it  "#can end the game" do
        it 'ends the game when you lose' do 
            
        end

        it 'ends the game when you win' do

        end

        it 'reports a winner' do

        end

        it 'returns to main menu' do

        end


    end



end