class Api::V1::GamesController < ApplicationController
  respond_to :json

  def index
    render :json => current_user.games
  end

  def create
    game = current_user.games.new(params[:game])
    if game.save
      render :json => game
    else
      render :json => {
        :success => false,
        :message => game.errors.full_messages.uniq.to_sentence
      }, :status => :unprocessable_entity
    end
  end

  def destroy

  end
end
