class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  # include Pundit

  before_filter :authenticate_user_from_token!, :except => [:greet]
  before_filter :authenticate_user!, :except => [:greet]

  # after_filter :verify_authorized, :except => [:greet]
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private

  def authenticate_user_from_token!
    auth_service = AuthenticationService.new
    user = auth_service.authenticated?(request.headers["email"], request.headers["token"])
    sign_in user, store: false if user
  end

  # def user_not_authorized
  #   current_user.logout
  #   render :nothing => true, :status => :unauthorized
  # end
end
