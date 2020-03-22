class Deck
  attr_reader :cards
  def initialize(deck_of_cards)
    @cards = deck_of_cards
  end
  
  def rank_of_card_at(index)
    cards[index].rank
  end
end