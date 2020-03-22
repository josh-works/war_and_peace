require './test/test_helper'

class DeckTest < Minitest::Test
  def setup
    @cards_array = []
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @cards_array.concat([@card_1, @card_2, @card_3])
    @deck = Deck.new(@cards_array)
  end
  
  def test_it_exists
    assert_equal @deck.cards.first, @cards_array.first
  end
  
  def test_rank_of_card_at_0_returns_rank_of_first_given_card
    assert_equal 12, @deck.rank_of_card_at(0)
  end
  
  def test_rank_of_card_at_2_returns_rank_of_3rd_given_card
    assert_equal 14, @deck.rank_of_card_at(2)
  end
  
  def test_high_ranking_cards_returns_only_highly_ranked_cards
    # "highly ranked cards" == cards with a rank of 11 or above 
    # aka face cards & aces
    assert_equal 2, @deck.high_ranking_cards.count
  end
  
  def test_high_ranking_cards_return_specific_highly_ranked_cards
    highly_ranked = @deck.high_ranking_cards
    assert_includes highly_ranked, @card_1
    assert_includes highly_ranked, @card_3 
    refute_includes highly_ranked, @card_2 
  end
  
  def test_percent_high_ranking_easy_version
    # aiming for 50
    card_1 = Card.new(:diamond, 'Queen', 12)
    card_2 = Card.new(:spade, '3', 3)
    cards_array = [card_1, card_2]
    deck = Deck.new(cards_array)
    assert_equal 50.0, deck.percent_high_ranking
  end
  
  def test_percent_high_ranking_harder_version
    # aiming for 33.33
    card_1 = Card.new(:diamond, 'Queen', 12)
    card_2 = Card.new(:spade, '3', 3)
    card_3 = Card.new(:spade, '4', 4)
    cards_array = [card_1, card_2, card_3]
    deck = Deck.new(cards_array)
    assert_equal 33.33, deck.percent_high_ranking
  end
  
  def test_add_card_adds_card_to_end_of_deck
    new_card = Card.new(:heart, 'Jack', 11)
    @deck.add_card(new_card)
    assert_equal new_card, @deck.cards.last
    assert_equal 4, @deck.cards.count
  end
  
  def test_remove_card
    card_to_remove = @deck.cards.first
    @deck.remove_card
    assert_equal 2, @deck.cards.count
    refute_includes @deck.cards, card_to_remove
  end
  
end
