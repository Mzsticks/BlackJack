# Blackjack — Ruby on Rails

A browser-based Blackjack game developed using Ruby on Rails as part of the Praeses Software Engineer coding assessment.

## Overview

This application implements a single-player Blackjack game against a computer-controlled dealer. Players can start a new game, request additional cards, stand on their current hand, and view the outcome of each round.

## Technology Stack

- Ruby 4.0.7
- Ruby on Rails 8.1.4
- PostgreSQL 18
- HTML templates
- Rails built-in testing framework 

## Features

- Standard 52-card deck, shuffled for each game
- Two initial cards dealt to the player and dealer
- Hit and Stand actions
- Dealer automatically draws until reaching at least 17
- Ace values dynamically calculated as 1 or 11
- Blackjack detection on the initial deal
- Win, loss, bust, and push outcomes
- Dealer's second card hidden until the round finishes
- New Game button to restart gameplay
- Automated tests for game logic and controller actions

## Installation and Setup

### Prerequisites

Install Ruby, Rails, PostgreSQL, and Git.

### Clone the Repository

```bash
git clone YOUR_REPOSITORY_URL
cd blackjack
```

### Install Dependencies

```bash
bundle install
```

### Configure PostgreSQL

Ensure PostgreSQL is running and that a PostgreSQL user with database-creation privileges is available.

The application reads the database password from the `POSTGRES_PASSWORD` environment variable.

For Windows PowerShell:

```powershell
$env:POSTGRES_PASSWORD = Read-Host "PostgreSQL password"
```

Update `config/database.yml` if your PostgreSQL username or connection settings differ.

### Prepare the Database

```bash
rails db:prepare
```

### Start the Application

```bash
rails server
```

Visit http://localhost:3000.

## How to Play

1. Click **New Game** to start a new round.
2. The player and dealer receive two cards each.
3. One dealer card remains hidden during the player's turn.
4. Click **Hit** to receive another card.
5. Click **Stand** to end your turn and let the dealer play.
6. The dealer draws until reaching at least 17.
7. The game displays the result when the round ends.

The goal is to finish with a hand closer to 21 than the dealer's without exceeding 21.

## Blackjack Rules

- Number cards count as their face values.
- Jack, Queen, and King count as 10.
- An Ace counts as 11 unless that would cause a bust, in which case it counts as 1.
- A hand exceeding 21 busts.
- A two-card hand totaling 21 is a natural blackjack.
- The dealer stands on all 17s
- Equal final scores result in a push!

## Running Tests

Execute the automated tests:

```bash
rails test
```

Tests cover initial dealing, card values, Ace adjustments, bust detection, dealer drawing, and HTTP controller actions.

## Architecture

The application separates the game rules from the web interface.

- `app/models/blackjack_game.rb` contains the Blackjack game logic.
- `app/controllers/games_controller.rb` handles player actions and game state.
- `app/views/games/show.html.erb` renders the interface.
- `config/routes.rb` defines the application routes.
- `test/` contains automated tests.

**The game currently stores round state in the Rails session. PostgreSQL is configured as the Rails application's database.**


