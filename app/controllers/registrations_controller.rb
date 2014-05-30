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
      handle_success(resource)
    else
      render :json => {
        :success => false,
        :message => resource.errors.full_messages.uniq.to_sentence
      }, :status => :unprocessable_entity
    end
  end
end

