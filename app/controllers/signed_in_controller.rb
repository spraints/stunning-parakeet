class SignedInController < ApplicationController
  before_filter :require_logged_in

  def require_logged_in
    session[:return_to] = request.path
    redirect_to "/auth/github" unless logged_in?
  end
end
