# frozen_string_literal: true

require 'sinatra/base'
require_relative './lib/game'
require_relative './lib/player'

class Battle < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  post '/names' do
    # no need of below's instance variables anymore, let's refactor them to global variables with $signs
    # session[:player_1_name] = params[:player_1_name]
    # session[:player_2_name] = params[:player_2_name]

  #took out this bit when do skinny controllers to tidy up the controller
    # $game = Game.new
    # $player_1 = Player.new(params[:player_1_name])
    # $player_2 = Player.new(params[:player_2_name])

  #and doing this instead
    player_1 = Player.new(params[:player_1_name])
    player_2 = Player.new(params[:player_2_name])
    $game = Game.new(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    # refactoring the session $player
    # @player_1_name = session[:player_1_name]
    # @player_2_name = session[:player_2_name]

  #took out this bit when do skinny controllers to tidy up the controller
    # @player_1 = $player_1
    # @player_2 = $player_2

  #and doing this instead
    @game = $game
    erb :play
  end

  get '/attack' do
    # refactoring the session with $player
    # @player_1_name = session[:player_1_name]
    # @player_2_name = session[:player_2_name]
    # @player_1_name = $player_1.name
    # @player_2_name = $player_2.name

    #took out this bit when do skinny controllers to tidy up the controller
    # @player_1 = $player_1
    # @player_2 = $player_2
    # $game.attack(@player_2)

    # @player_1.attack(@player_2)

  #took out this bit when do skinny controllers to tidy up the controller
    # Game.new.attack(@player_2)

  #and doing this instead
    @game = $game
  #taking this out from user story I wanna player 2's attack to take my HP out and add
    # @game.attack(@game.player_2)
    @game.attack(@game.opponent_of(@game.current_turn))
  #taking this out from user story I want to get confirmation Player 2 is hitting me
    # @game.switch_turns
    erb :attack
  end

  #adding this from user story to get confirmation PLayer 2 is hitting me
  post '/switch-turns' do
    $game.switch_turns
    redirect('./play')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
