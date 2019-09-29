# frozen_string_literal: true

class User < Player
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
end
