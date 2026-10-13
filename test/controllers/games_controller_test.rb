
require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should display blackjack game" do
    get root_url

    assert_response :success
    assert_select "h1", "BLACKJACK"
    assert_select "h2", "Your Hand"
  end

  test "should start a new game" do
    post new_game_url

    assert_redirected_to root_url

    follow_redirect!

    assert_response :success
    assert_select "h1", "BLACKJACK"
  end

  test "should allow player to hit" do
    get root_url

    post hit_url

    assert_redirected_to root_url
  end

  test "should allow player to stand" do
    get root_url

    post stand_url

    assert_redirected_to root_url
  end
end
