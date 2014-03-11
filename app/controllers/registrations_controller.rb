class RegistrationsController < Devise::RegistrationsController

  skip_before_filter :authenticate_user_from_token!
  skip_after_filter  :verify_authorized

  respond_to :json
  def create
    # Create the user
    build_resource(sign_up_params)
    resource.username = params[:user][:username]
    # Try to save them
    if resource.save
      sign_in resource
      #TODO: move this to a helper/module because it's also in
      #sessionscontroller
      token = resource.ensure_authentication_token
      email = AES.encrypt(resource.email, Gamelend::Application.config.secret_key_base)
      render :json => {:success => true, :email => email, :token => token, :username => resource.username}
    else
      render :json => {
        :success => false,
        :message => resource.errors.full_messages.uniq.to_sentence
      }, :status => :unprocessable_entity
    end
  end
end

