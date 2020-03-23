require './test/test_helper'

class TurnTest < Minitest::Test
  
  def setup
    # p1 setup
    p1_card_1 = Card.new(:diamond, 'Queen', 12)
    p1_card_2 = Card.new(:spade, '3', 3)
    p1_card_3 = Card.new(:heart, 'Ace', 14)
    p1_deck = Deck.new([p1_card_1, p1_card_2, p1_card_3])
    @player_1 = Player.new('Josh', p1_deck)
    
    # p2 setup
    p2_card_1 = Card.new(:diamond, 'King', 13)
    p2_card_2 = Card.new(:heart, '3', 3)
    p2_card_3 = Card.new(:club, 'Ace', 14)
    p2_deck = Deck.new([p2_card_1, p2_card_2, p2_card_3])
    @player_2 = Player.new('Jen', p2_deck)
    
    # turn setup
    @turn = Turn.new(@player_1, @player_2)
  end
  
  def test_turn_basic_attributes
    assert_equal @player_1, @turn.player_1
    assert_equal @player_2, @turn.player_2
    assert_empty @turn.spoils_of_war
  end
  
  def test_type_is_basic_if_top_cards_differ_in_rank
    assert_equal :basic, @turn.type
  end
  
  def test_type_is_war_if_top_cards_are_of_same_rank
    war_setup
    assert_equal :war, @war_turn.type
  end
  
  def test_type_is_mutually_assured_destruction_if_top_and_third_card_have_same_rank
    mad_setup
    assert_equal :mutually_assured_destruction, @mad_turn.type
  end
  
  def test_winner_basic_turn_type
    assert_equal :basic, @turn.type
    assert_equal @player_2, @turn.winner
  end
  
  def test_winner_war_turn_type
    war_setup
    assert_equal :war, @war_turn.type
    assert_equal @war_turn.player_2, @war_turn.winner
    
  end
  
  def test_winner_mad_turn_type
    mad_setup
    assert_equal :mutually_assured_destruction, @mad_turn.type
    assert_equal "No Winner", @mad_turn.winner
  end
  
  def test_pile_cards_basic_moves_cards_from_players_deck_to_spoils
    # basic setup
    p1_starting_card = @player_1.deck.cards.first
    p2_starting_card = @player_2.deck.cards.first
    @turn.pile_cards
    assert_equal 2, @turn.spoils_of_war.count
    assert_includes @turn.spoils_of_war, p1_starting_card
    assert_includes @turn.spoils_of_war, p2_starting_card
    refute_includes @player_1.deck.cards, p1_starting_card
    refute_includes @player_2.deck.cards, p2_starting_card
  end
  
  def test_pile_cards_war_moves_cards_from_players_deck_to_spoils
    # both players lose three cards TO spoils_of_war
    war_setup
    @war_turn.pile_cards
    assert_equal 6, @war_turn.spoils_of_war.count
    assert_equal 0, @war_turn.player_1.deck.cards.count
    assert_equal 0, @war_turn.player_2.deck.cards.count
  end
  
  def test_pile_cards_mad_moves_cards_from_players_deck_to_spoils
    # both players lose 3 cards, don't go to spoils_of_war
    mad_setup
    @mad_turn.pile_cards
    assert_equal 0, @mad_turn.spoils_of_war.count
    assert_equal 0, @mad_turn.player_1.deck.cards.count
    assert_equal 0, @mad_turn.player_2.deck.cards.count
  end
  
  def test_award_spoils_sends_spoils_to_winner_of_basic_turn
    # basic setup
    @turn.pile_cards
    @turn.award_spoils
    assert_empty @turn.spoils_of_war
    assert_equal 4, @player_2.deck.cards.count
    assert_equal 2, @player_1.deck.cards.count
  end
  
  def test_award_spoils_sends_spoils_to_winner_of_war_turn
    war_setup
    @war_turn.pile_cards
    @war_turn.award_spoils
    assert_empty @war_turn.spoils_of_war
    assert_equal 6, @war_turn.player_2.deck.cards.count
    assert_equal 0, @war_turn.player_1.deck.cards.count
  end
  
  def test_award_spoils_does_not_do_anything_if_mad_turn
    mad_setup
    @mad_turn.pile_cards
    @mad_turn.award_spoils
    assert_empty @mad_turn.spoils_of_war
    assert_equal 0, @mad_turn.player_1.deck.cards.count
    assert_equal 0, @mad_turn.player_2.deck.cards.count
  end
  
  
  def war_setup
    # p1 setup
    p1_card_1 = Card.new(:diamond, 'Queen', 12)
    p1_card_2 = Card.new(:spade, '3', 3)
    p1_card_3 = Card.new(:heart, 'King', 13)
    p1_deck = Deck.new([p1_card_1, p1_card_2, p1_card_3])
    war_p1 = Player.new('Josh', p1_deck)
    
    # p2 setup
    p2_card_1 = Card.new(:club, 'Queen', 12)
    p2_card_2 = Card.new(:heart, '3', 3)
    p2_card_3 = Card.new(:club, 'Ace', 14)
    p2_deck = Deck.new([p2_card_1, p2_card_2, p2_card_3])
    war_p2 = Player.new('Jen', p2_deck)
    
    # turn setup
    @war_turn = Turn.new(war_p1, war_p2)
  end
  
  def mad_setup
    # p1 setup
    p1_card_1 = Card.new(:diamond, 'Queen', 12)
    p1_card_2 = Card.new(:spade, '3', 3)
    p1_card_3 = Card.new(:heart, 'Ace', 14)
    p1_deck = Deck.new([p1_card_1, p1_card_2, p1_card_3])
    mad_p1 = Player.new('Josh', p1_deck)
    
    # p2 setup
    p2_card_1 = Card.new(:club, 'Queen', 12)
    p2_card_2 = Card.new(:heart, '3', 3)
    p2_card_3 = Card.new(:club, 'Ace', 14)
    p2_deck = Deck.new([p2_card_1, p2_card_2, p2_card_3])
    mad_p2 = Player.new('Jen', p2_deck)
    
    # turn setup
    @mad_turn = Turn.new(mad_p1, mad_p2)
  end
end