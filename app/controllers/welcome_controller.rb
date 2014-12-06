class WelcomeController < ApplicationController

  before_filter :redirect_to_atm_if_logged

  def index
  end

  private
  def redirect_to_atm_if_logged
    redirect_to atm_url if current_account
  end

end
