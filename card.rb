# frozen_string_literal: true

class Card
  attr_reader :type, :suit, :value

  def initialize(type, suit, value)
    @type = type
    @suit = suit
    @value = value
  end

  def face
    type + suit
  end
end
