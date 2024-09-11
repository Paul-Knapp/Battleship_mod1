# Run Battleship
require './lib/turn'
require './lib/board'
require './lib/ship'
require './lib/game'
game = Game.new
game.start


play_again = gets.chomp

if play_again == 'p'
  exec('ruby', __FILE__) # This will restart the current Ruby script.
end
