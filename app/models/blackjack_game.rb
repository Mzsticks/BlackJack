
class BlackjackGame
  SUITS = %w[♠ ♥ ♦ ♣].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  attr_reader :player_hand, :dealer_hand, :status, :result

  def initialize
    @deck = SUITS.product(RANKS).map do |suit, rank|
      { suit: suit, rank: rank }
    end.shuffle

    @player_hand = []
    @dealer_hand = []
    @status = "playing"
    @result = nil

    2.times do
      @player_hand << @deck.pop
      @dealer_hand << @deck.pop
    end

    check_initial_blackjack
  end

  def score(hand)
    total = hand.sum do |card|
      case card[:rank]
      when "A" then 11
      when "J", "Q", "K" then 10
      else card[:rank].to_i
      end
    end

    aces = hand.count { |card| card[:rank] == "A" }

    while total > 21 && aces > 0
      total -= 10
      aces -= 1
    end

    total
  end

  def hit
    return unless @status == "playing"

    @player_hand << @deck.pop

    if score(@player_hand) > 21
      @status = "finished"
      @result = "Player busts! Dealer wins."
    elsif score(@player_hand) == 21
      stand
    end
  end

  def stand
    return unless @status == "playing"

    while score(@dealer_hand) < 17
      @dealer_hand << @deck.pop
    end

    player_score = score(@player_hand)
    dealer_score = score(@dealer_hand)

    @result =
      if dealer_score > 21
        "Dealer busts! You win!"
      elsif player_score > dealer_score
        "You win!"
      elsif player_score < dealer_score
        "Dealer wins!"
      else
        "Push! It's a tie."
      end

    @status = "finished"
  end

  def finished?
    @status == "finished"
  end

  private

  def check_initial_blackjack
    player_blackjack = score(@player_hand) == 21
    dealer_blackjack = score(@dealer_hand) == 21

    return unless player_blackjack || dealer_blackjack

    @status = "finished"

    @result =
      if player_blackjack && dealer_blackjack
        "Both have Blackjack! Push!"
      elsif player_blackjack
        "Blackjack! You win!"
      else
        "Dealer has Blackjack!"
      end
  end
end

