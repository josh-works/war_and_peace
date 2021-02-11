require './lib/helper'

class GameRunner
  attr_reader :p1, :p2, :cards, :turn_count, :winner
  def initialize
    cards = make_cards
    deck_1 = Deck.new(cards.pop(26))
    deck_2 = Deck.new(cards)
    @p1 = Player.new("j1", deck_1)
    @p2 = Player.new("j2", deck_2)
    @turn_count = 0
    @winner = nil
  end
  
  def start
    puts messages[:welcome]
    input = gets.chomp.downcase
    if input == 'go'
      until we_have_a_winner?
        take_a_turn
      end
    else
      puts "unclear input. You said #{input}, please try again"
      start
    end
    puts messages[:game_over]
  end
  
  private
  
  def take_a_turn
    @turn_count += 1
    turn = Turn.new(p1, p2)
    @winner = turn.winner
    
    turn.pile_cards
    turn.award_spoils
    
    print_conclusion(turn)
  end
  
  def print_conclusion(turn)
    message = "Turn #{turn_count.to_s}: "
    case turn.type
    when :basic
      message += messages[:basic]
    when :war
      message += messages[:war]
    when :mutually_assured_destruction
      message += messages[:mad]
    end
    puts message
  end
  
  def we_have_a_winner?
    @p1.has_lost? || @p2.has_lost?
  end
  
  def messages
    {
    welcome: 
    "Welcome to War! (or Peace) This game will be played with 52 cards.\n
    The players today are #{p1.name} and #{p2.name}.\n
    Type 'GO' to start the game!
    ------------------------------------------------------------------",
    basic: "#{winner.name if winner} won 2 cards",
    war: "WAR - #{winner.name if winner} won 6 cards",
    mad: "*mutually assured destruction* 6 cards removed from play",
    game_over: "*~*~*~* #{winner.name if winner} has won the game! *~*~*~*"
    }
  end
  
  def make_cards
    cards_array = []
    suits = [:diamond, :spade, :heart, :club]
    suits.each do |suit|
      values = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']
      value_rank_pairs = values.zip((1..14).to_a)
      value_rank_pairs.each do |vr|
        card = Card.new(suit, vr[0], vr[1])
        cards_array << card
      end
    end
    cards_array.shuffle
  end
end

GameRunner.new.start
