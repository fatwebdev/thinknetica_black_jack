# frozen_string_literal: true

class Game
  def initialize(player)
    @players = [player, Dealer.new]
    @deck = Deck.new
  end

  def start
    if players.any?(&:bankrupt?)
      log(:one_of_player_bankrupt, {})
      return
    end

    reset_players_state
    game_start
    deal_cards
    rates
    game_loop
    pay_winners
  end

  protected

  attr_accessor :bank, :game_status
  attr_reader :players, :deck

  private

  def reset_players_state
    players.each(&:reset)
  end

  def rates
    self.bank = players.reduce(0) do |acc, player|
      amount = player.bet
      log(:rate, name: player.name, amount: amount)
      acc + amount
    end
  end

  def game_start
    self.game_status = :start
    log(:game_start, {})
  end

  def game_end
    self.game_status = :end
  end

  def game_end?
    game_status == :end
  end

  def deal_cards
    players.each do |player|
      2.times { take_card(player) }
    end
  end

  def game_loop
    loop do
      players.each do |player|
        action = player.turn

        send action, player

        break if game_end?
      end

      break if game_end?
    end
  end

  def pass(player)
    log(:pass, name: player.name)
  end

  def card_score(card, player)
    type = card[0..-2]

    if type == 'A'
      return player.score <= 10 ? 11 : 10
    end

    type.to_i.zero? ? 10 : type.to_i
  end

  def take_card(player)
    card = deck.take_card
    score = card_score(card, player)

    player.add_card(card, score)

    log(:take_card, name: player.name)

    show_hand(player) if player.cards.count > 2
  end

  def show_hand(_player)
    log_data = players.each_with_object({}) do |player, acc|
      acc[player.name.to_sym] = {
        cards: player.show_cards,
        score: player.score
      }
    end

    log(:show_hand, log_data)

    game_end
  end

  def dealer_win
    players[0..-2].all? do |player|
      player.score > 21
    end
  end

  def drawn_game
    players.group_by(&:score).length == 1
  end

  def winner
    players.min_by { |player| 21 - player.score }
  end

  def take_winners
    return [players.last] if dealer_win

    return players if drawn_game

    [winner]
  end

  def pay_winners
    winners = take_winners
    amount = bank / winners.count
    winners.each do |winner|
      self.bank -= amount
      log(:winner, name: winner.name, amount: amount)
      winner.take_money(amount)
    end

    start if new_game?
  end

  def new_game?
    print 'Enter any symbol for new game or q for exit... '
    choice = gets.chomp
    puts
    choice != 'q'
  end

  def log(action, **data)
    players.each { |player| player.game_status(action, data) }
  end
end
