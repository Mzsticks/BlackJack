
class GamesController < ApplicationController
  def show
    session[:game] ||= serialize_game(BlackjackGame.new)
    @game = load_game
  end

  def hit
    game = load_game
    game.hit
    session[:game] = serialize_game(game)
    redirect_to root_path
  end

  def stand
    game = load_game
    game.stand
    session[:game] = serialize_game(game)
    redirect_to root_path
  end

  def new
    session[:game] = serialize_game(BlackjackGame.new)
    redirect_to root_path
  end

  private

  def serialize_game(game)
    {
      deck: game.instance_variable_get(:@deck),
      player_hand: game.player_hand,
      dealer_hand: game.dealer_hand,
      status: game.status,
      result: game.result
    }
  end

  def load_game
    data = session[:game]
    return BlackjackGame.new unless data

    game = BlackjackGame.allocate

    %w[deck player_hand dealer_hand status result].each do |key|
      value = data[key] || data[key.to_sym]

      if %w[deck player_hand dealer_hand].include?(key)
        value = value.map { |card| card.symbolize_keys }
      end

      game.instance_variable_set("@#{key}", value)
    end

    game
  end
end

