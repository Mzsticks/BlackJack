
Rails.application.routes.draw do
  root "games#show"

  post "/hit", to: "games#hit", as: :hit
  post "/stand", to: "games#stand", as: :stand
  post "/new_game", to: "games#new", as: :new_game
end
