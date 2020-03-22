class Turn
  attr_reader :player_1, :player_2, :spoils_of_war, :type
  def initialize(p1, p2)
    @player_1 = p1
    @player_2 = p2
    @spoils_of_war = []
    @type = determine_turn_type
  end
  
  def determine_turn_type
    return :mutually_assured_destruction if !first_cards_diff_rank? && third_card_diff_rank?
    return :war if !first_cards_diff_rank?
    return :basic if first_cards_diff_rank?
  end
  
  private
  
    def third_card_diff_rank?
      rank_1 = player_1.deck.rank_of_card_at(2)
      rank_2 = player_2.deck.rank_of_card_at(2)
      rank_1 == rank_2
    end
  
    def first_cards_diff_rank?
      p1_first_card.rank != p2_first_card.rank
    end
  
    def p1_first_card
      player_1.deck.cards.first
    end
    
    def p2_first_card
      player_2.deck.cards.first
    end
end