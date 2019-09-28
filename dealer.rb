# frozen_string_literal: true

class Dealer < Player
  def initialize
    super('Dealer')
  end

  def turn
    score >= 17 ? :pass : :take_card
  end
end
