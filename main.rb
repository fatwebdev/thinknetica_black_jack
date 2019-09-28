# frozen_string_literal: true

require_relative './player.rb'
require_relative './user.rb'
require_relative './dealer.rb'

require_relative './deck.rb'

require_relative './game.rb'

print 'Enter your name... '
name = gets.chomp
user = User.new(name)
puts

game = Game.new(user)
game.start
