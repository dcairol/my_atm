class AtmController < ApplicationController

  before_filter :verify_current_account, except: [ :authenticate ]

  def index
  end

  def authenticate
    begin
      if authenticate_user
        redirect_to action: "index"
      end
    rescue InvalidAccessError => e
      flash[:error] = e.message
      redirect_to_login
    end
  end

  def withdraw
    respond_to do |format|
      begin
        amount = $atm.withdraw(params[:amount].to_i)
        format.json{ render json: { success: true, new_balance: $atm.current_account_balance, dispensed: amount } }
      rescue StandardError => e
        format.json{ render json: { error: true, message: e.message } }
      end
    end
  end

  def finish
    $atm.finish_transactions
    redirect_to_login
  end

  private
  def redirect_to_login
    redirect_to welcome_url
  end

  def authenticate_user
    $atm = AtmMachine.new
    $atm.authenticate(params[:number], params[:pin])
    session[:current_account] = $atm.current_account.id
  end

  def verify_current_account
    session[:current_account]=nil unless $atm
    redirect_to_login and return unless current_account
    @current_account = BankAccount.find current_account
  end
end
