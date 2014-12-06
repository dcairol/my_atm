class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?

  end

  def current_account
    session[:current_account]
  end

  def current_account=(account)
    session[:current_account] = account
  end

end
