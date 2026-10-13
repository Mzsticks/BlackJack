
require "test_helper"

class BlackjackGameTest < ActiveSupport::TestCase
  setup do
    @game = BlackjackGame.new
  end

  test "starts with two cards for each player" do
    assert_equal 2, @game.player_hand.length
    assert_equal 2, @game.dealer_hand.length
  end

  test "deck contains 48 remaining cards after dealing" do
    assert_equal 48, @game.instance_variable_get(:@deck).length
  end

  test "face cards are worth ten" do
    hand = [
      { rank: "K", suit: "♠" },
      { rank: "Q", suit: "♥" }
    ]

    assert_equal 20, @game.score(hand)
  end

  test "ace counts as eleven when possible" do
    hand = [
      { rank: "A", suit: "♠" },
      { rank: "9", suit: "♥" }
    ]

    assert_equal 20, @game.score(hand)
  end

  test "ace changes to one to prevent bust" do
    hand = [
      { rank: "A", suit: "♠" },
      { rank: "9", suit: "♥" },
      { rank: "5", suit: "♦" }
    ]

    assert_equal 15, @game.score(hand)
  end

  test "player bust ends the game" do
    @game.instance_variable_set(:@player_hand, [
      { rank: "K", suit: "♠" },
      { rank: "9", suit: "♥" }
    ])

    @game.instance_variable_set(:@deck, [
      { rank: "5", suit: "♦" }
    ])

    @game.instance_variable_set(:@status, "playing")

    @game.hit

    assert @game.finished?
    assert_match(/bust/i, @game.result)
  end

  test "dealer draws until at least seventeen" do
    @game.instance_variable_set(:@player_hand, [
      { rank: "10", suit: "♠" },
      { rank: "8", suit: "♥" }
    ])

    @game.instance_variable_set(:@dealer_hand, [
      { rank: "7", suit: "♣" },
      { rank: "8", suit: "♦" }
    ])

    @game.instance_variable_set(:@deck, [
      { rank: "4", suit: "♠" }
    ])

    @game.instance_variable_set(:@status, "playing")

    @game.stand

    assert_operator @game.score(@game.dealer_hand), :>=, 17
    assert @game.finished?
  end
end

