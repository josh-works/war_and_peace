require './test/test_helper'

class CardTest < Minitest::Test
  
  def test_it_exists
    card = Card.new(:heart, 'Jack', 11)
    assert_equal :heart, card.suit
    assert_equal "Jack", card.value
    assert_equal 11, card.rank
  end
  
  def test_highly_ranked_eh_returns_true_for_high_value_card
    high_card = Card.new(:heart, 'Jack', 11)
    assert high_card.highly_ranked?
  end
  
  def test_highly_ranked_eh_returns_false_for_low_value_card
    low_card = Card.new(:heart, '10', 10)
    refute low_card.highly_ranked?
  end
  
end
