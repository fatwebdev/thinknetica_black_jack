# frozen_string_literal: true

require_relative './player.rb'
require_relative './console_user.rb'
require_relative './dealer.rb'

require_relative './card.rb'
require_relative './deck.rb'

require_relative './game.rb'

user = ConsoleUser.new

game = Game.new(user)
game.start
