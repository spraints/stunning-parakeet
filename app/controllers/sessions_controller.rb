class SessionsController < ApplicationController
  def omniauth_callback
    auth_hash = request.env["omniauth.auth"]
    user = User.where(:github_user_id => auth_hash.uid).first_or_initialize
    user.auth_token = auth_hash.credentials.token
    user.save!
    self.current_user = user
    redirect_to(session[:return_to] || "/")
  end
end
