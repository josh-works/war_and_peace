class Turn
  attr_reader :player_1, :player_2, :spoils_of_war, :type
  def initialize(p1, p2)
    @player_1 = p1
    @player_2 = p2
    @spoils_of_war = []
    @type = determine_turn_type
  end
  
  def determine_turn_type
    return :mutually_assured_destruction if top_card_same_rank? && third_card_same_rank?
    return :war if top_card_same_rank?
    return :basic if !top_card_same_rank?
  end
  
  def winner
    case type
    when :basic 
      player_with_highest_first_card
    when :war 
      player_with_highest_third_card
    when :mutually_assured_destruction
      "No Winner"
    end
  end
  
  def pile_cards
    case type
    when :basic
      basic_card_adjustment
    when :war
      war_card_adjustment
    when :mutually_assured_destruction
      mad_card_adjustment
    end
  end
  
  
  private
  
  def war_card_adjustment
    old_p1_cards = player_1.remove_cards(3)
    old_p2_cards = player_2.remove_cards(3)
    @spoils_of_war += old_p1_cards
    @spoils_of_war += old_p2_cards
  end
  
  def basic_card_adjustment
    c1 = player_1.remove_cards(1)
    c2 = player_2.remove_cards(1)
    @spoils_of_war += c1
    @spoils_of_war += c2
  end
  
  def mad_card_adjustment
    player_1.remove_cards(3)
    player_2.remove_cards(3)
  end
  
    def player_with_highest_third_card
      return player_1 if p1_card_2_rank > p2_card_2_rank
      player_2
    end
  
    def player_with_highest_first_card
      return player_1 if p1_card_0_rank > p2_card_0_rank
      return player_2
    end
  
    def third_card_same_rank?
      p1_card_2_rank == p2_card_2_rank
    end
  
    def top_card_same_rank?
      p1_card_0_rank == p2_card_0_rank
    end
    
    def p1_card_2_rank
      player_1.second_card_rank
    end
    
    def p2_card_2_rank
      player_2.second_card_rank
    end
  
    def p1_card_0_rank
      player_1.top_card_rank
    end
    
    def p2_card_0_rank
      player_2.top_card_rank
    end
end