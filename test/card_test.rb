require './test/test_helper'

class CardTest < Minitest::Test
  
  def test_it_exists
    card = Card.new(:heart, 'Jack', 11)
    assert_equal :heart, card.suit
    assert_equal "Jack", card.value
    assert_equal 11, card.rank
  end
  
end
