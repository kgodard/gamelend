class SessionsController < Devise::SessionsController

  skip_before_filter :authenticate_user_from_token!, :only => [:create]
  skip_after_filter  :verify_authorized

  def create
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return failure unless resource
    return failure unless resource.valid_password?(params[:user][:password])
    handle_success(resource)
  end

  def failure
    render :json => {:success => false, :message => "invalid login credentials"}, :status => :unauthorized
  end

  def destroy
    current_user.logout
    render :json => {:success => true, :message => "logged out"}
  end
end
