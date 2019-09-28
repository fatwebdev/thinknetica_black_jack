# frozen_string_literal: true

class Player
  attr_reader :name, :amount, :cards

  def initialize(name, amount)
    @name = name
    @amount = amount

    @cards = []
  end

  def cards=(card)
    cards << card
  end
end
