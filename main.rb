# frozen_string_literal: true

require_relative './player.rb'
require_relative './user.rb'
require_relative './dealer.rb'

require_relative './card.rb'
require_relative './deck.rb'

require_relative './game.rb'

user = User.new

game = Game.new(user)
game.start
