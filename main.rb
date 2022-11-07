require './game.rb'

game = Game.new
until game.check
  pos = gets.chomp
  game.play(pos)
end
