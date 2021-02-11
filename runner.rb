require './lib/helper'

class GameRunner
  attr_reader :p1, :p2, :cards
  def initialize
    cards = make_cards
    deck_1 = Deck.new(cards.pop(26))
    deck_2 = Deck.new(cards)
    @p1 = Player.new("j1", deck_1)
    @p2 = Player.new("j2", deck_2)
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
  end
  
  private
  
  def take_a_turn
    require "pry"; binding.pry
  end
  
  def we_have_a_winner?
    @p1.has_lost? || @p2.has_lost?
  end
  
  def messages
    {
    welcome: "Welcome to War! (or Peace) This game will be played with 52 cards.\n
    The players today are #{p1.name} and #{p2.name}.
    Type 'GO' to start the game!
    ------------------------------------------------------------------",
    
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