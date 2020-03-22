require './test/test_helper'

class DeckTest < Minitest::Test
  def setup
    @cards_array = []
    @cards_array << Card.new(:diamond, 'Queen', 12)
    @cards_array << Card.new(:spade, '3', 3)
    @cards_array << Card.new(:heart, 'Ace', 14)
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
  
end
