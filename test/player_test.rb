require './test/test_helper'

class PlayerTest < Minitest::Test
  
  def setup
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_1 = Card.new(:spade, '3', 3)
    @card_1 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @player = Player.new('Josh', @deck)
  end
  
  def test_player_attributes
    assert_equal "Josh", @player.name
    assert_equal @deck, @player.deck
  end
  
  def test_has_lost_eh_returns_false_if_deck_has_cards_in_it
    refute @player.has_lost?
    @player.deck.remove_card
    @player.deck.remove_card
    @player.deck.remove_card
    assert @player.has_lost?
  end
end