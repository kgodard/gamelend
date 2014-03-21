class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    render :json => current_user.games
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

  def destroy
    game = current_user.games.find(params[:id])

    if game.destroy
      render_json_response :ok
    else
      render_json_response :error, :message => 'could not delete game'
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :system, :developer)
  end
end
