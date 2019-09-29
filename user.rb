# frozen_string_literal: true

class User < Player
  GAME_STATUSES = {
    one_of_player_bankrupt: lambda do |_data|
      puts 'one of the players doesn\'t have enough money for game'
    end,
    game_start: ->(_data) { puts 'Game start' },
    take_card: ->(data) { puts "#{data[:name]} take card" },
    rate: ->(data) { puts "#{data[:name]} rate #{data[:amount]}" },
    pass: ->(data) { puts "#{data[:name]} pass" },
    show_hand: lambda do |data|
      data.each do |player, info|
        puts "#{player} has on hand: #{info[:cards]} with total score: #{info[:score]}"
      end
    end,
    winner: ->(data) { puts "Winner #{data[:name]} take #{data[:amount]}" }
  }.freeze

  def initialize
    print 'Enter your name... '
    name = gets.chomp
    puts
    super(name)
  end

  def turn_options
    {
      pass: '1 - pass',
      take_card: '2 - take card',
      show_hand: '3 - show hand'
    }
  end

  def render_info
    puts "You have #{amount} money, cards on hand: #{show_cards} with total score: #{score}"
  end

  def turn
    render_info
    choiced = choice
    puts
    turn_options.keys[choiced - 1]
  end

  def choice
    puts turn_options.values
    print 'Select option... '
    gets.chomp.to_i
  end

  def game_status(action, data)
    GAME_STATUSES[action].call(data)
  end
end
