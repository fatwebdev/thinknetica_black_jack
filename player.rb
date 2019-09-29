# frozen_string_literal: true

class Player
  attr_accessor :score, :amount, :cards
  attr_reader :name

  def initialize(name)
    @name = name

    @amount = 100

    @score = 0
    @cards = []
  end

  def add_card(card, score)
    cards << card
    self.score += score
  end

  def show_cards
    cards.join(', ')
  end

  def bet
    self.amount -= 10
    10
  end

  def take_money(amount)
    self.amount += amount
  end

  def reset
    self.score = 0
    self.cards = []
  end

  def bankrupt?
    amount.zero?
  end

  def game_status(_action, _data); end

  def continue?
    !bankrupt?
  end
end
