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
  
  def percent_high_ranking
    total_card_count = cards.count.to_f
    high_ranking_count = high_ranking_cards.count
    (high_ranking_count / total_card_count * 100).round(2)
  end
  
  def add_card(card)
    @cards << card
  end
  
  def remove_card
    @cards.shift
  end
end