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

  def handle_success(resource)
    token = resource.ensure_authentication_token
    email = AES.encrypt(resource.email, Gamelend::Application.config.secret_key_base)
    render :json => {:success => true, :email => email, :token => token, :username => resource.username}
  end

  def render_json_response(type, hash={})
    unless [ :ok, :redirect, :error ].include?(type)
      raise "Invalid json response type: #{type}"
    end

    default_json_structure = {
      :status => type,
      :html => nil,
      :message => nil,
      :to => nil }.merge(hash)

    render_options = {:json => default_json_structure}
    render_options[:status] = 400 if type == :error

    render(render_options)
  end


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
