class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_uesr = user
    session[:current_user_id] = user.id
  end

  def current_user
    if @current_user.nil?
      @current_user = user_from_session || false
    end
    @current_user || nil
  end

  def user_from_session
    if user_id = session[:current_user_id]
      User.where(:id => user_id).first
    end
  end
end
