class Deck
  attr_reader :cards
  def initialize(deck_of_cards)
    @cards = deck_of_cards
  end
  
  def rank_of_card_at(index)
    cards[index].rank
  end
  
  def high_ranking_cards
    # return face cards and aces
    cards.select { |c| c.highly_ranked? }
  end
end