# frozen_string_literal: true

class Deck
  def initialize
    @deck = generate_deck
  end

  def take_card
    deck.pop
  end

  private

  attr_reader :deck

  def generate_deck
    suits = %w[♠ ♥ ♦ ♣]
    types = (2..10).to_a + %w[J Q K A]

    suits.reduce([]) do |acc, suit|
      acc + types.map { |type| type.to_s + suit }
    end.shuffle
  end
end
