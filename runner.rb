require './lib/helper'

class GameRunner
  attr_reader :p1, :p2, :cards
  def initialize
    cards = make_cards
    deck_1 = @cards.pop(26)
    deck_2 = @cards
    @p1 = Player.new("j1", deck_1)
    @p2 = Player.new("j2", deck_2)
  end
  
  private
  
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