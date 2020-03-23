require './test/test_helper'

class PlayerTest < Minitest::Test
  
  def setup
    @card_1 = Card.new(:diamond, 'Queen', 12)
    @card_2 = Card.new(:spade, '3', 3)
    @card_3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @player = Player.new('Josh', @deck)
  end
  
  def test_player_attributes
    assert_equal "Josh", @player.name
    assert_equal @deck, @player.deck
    assert_equal 3, @player.deck.cards.count
  end
  
  def test_has_lost_eh_returns_false_if_deck_has_cards_in_it
    refute @player.has_lost?
    @player.deck.remove_card
    @player.deck.remove_card
    @player.deck.remove_card
    assert @player.has_lost?
  end
  
  def test_remove_card_one_removes_first_cards
    @player.remove_cards(1)
    assert_equal 2, @player.deck.cards.count
    refute_includes @player.deck.cards, @card_1
  end
  
  def test_remove_cards_three_removes_first_three_cards
    old_cards = @player.remove_cards(3)
    assert_equal 0, @player.deck.cards.count
    assert_includes old_cards, @card_1
    assert_includes old_cards, @card_2
    assert_includes old_cards, @card_3
  end
    
end