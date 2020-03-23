class Player
  attr_reader :name, :deck
  def initialize(name, deck)
    @name = name
    @deck = deck
  end
  
  def has_lost?
    deck.cards.empty?
  end
  
  def top_card_rank
    deck.rank_of_card_at(0)
  end
  
  def second_card_rank
    deck.rank_of_card_at(2)
  end
  
  def remove_cards(count)
    @deck.cards.shift(count)
  end
  
  def add_cards(cards)
    @deck.add_card(cards)
  end
end