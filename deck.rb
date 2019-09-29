# frozen_string_literal: true

class Deck
  SUITS = %w[♠ ♥ ♦ ♣].freeze
  TYPES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  VALUES = [
    2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [10, 11]
  ].freeze

  def initialize
    @deck = generate_deck
  end

  def take_card
    deck.pop
  end

  private

  attr_reader :deck

  def generate_deck
    SUITS.reduce([]) do |acc, suit|
      acc + TYPES.map.with_index { |type, idx| Card.new(type, suit, VALUES[idx]) }
    end.shuffle
  end
end
