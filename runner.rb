# Run Battleship
require './lib/turn'
require './lib/board'
require './lib/ship'
require './lib/game'
game = Game.new
game.start

p 'press p to play again :'
play_again = gets.chomp
puts ':' + play_again

if play_again == 'p'
  exec('ruby', __FILE__) # This will restart the current Ruby script.
end
