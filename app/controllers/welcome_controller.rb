class WelcomeController < ApplicationController

  before_filter :change_current_account_if_necessary, :redirect_to_atm_if_logged

  def index
  end

  private
  def redirect_to_atm_if_logged
    redirect_to atm_url if current_account
  end

end
