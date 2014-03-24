class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    render json: current_user.games
  end

  def show
    if game = find_game
      render json: game
    else
      render_json_response :error, :message => "No game found for given id: #{params[:id]}"
    end
  end

  def create
    game = current_user.games.new(game_params)
    if game.save
      render_json_response :ok
    else
      errors = game.errors.full_messages.uniq.to_sentence
      render_json_response :error, :message => errors
    end
  end

  def update
    game = find_game
    if game.update_attributes(game_params)
      render_json_response :ok
    else
      errors = game.errors.full_messages.uniq.to_sentence
      render_json_response :error, :message => errors
    end
  rescue ActiveRecord::RecordNotFound
    render_json_response :error, :message => "could not find game with id: #{params[:id]}"
  end

  def destroy
    game = find_game
    if game.destroy
      render_json_response :ok
    else
      render_json_response :error, :message => 'could not delete game'
    end
  rescue ActiveRecord::RecordNotFound
    render_json_response :error, :message => "could not find game with id: #{params[:id]}"
  end

  private

  def find_game
    current_user.games.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :system, :developer)
  end
end
