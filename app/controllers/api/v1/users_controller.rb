class Api::V1::UsersController < ApplicationController
  respond_to :json

  def index
    users = User.all - [current_user]
    render json: users.to_json(only: [:id, :email])
  end
end

