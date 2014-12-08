class AtmController < ApplicationController

  before_filter :change_current_account_if_necessary, except: [ :authenticate ]
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
        amount = AtmMachine.withdraw(params[:amount].to_i)
        format.json{ render json: { success: true, new_balance: AtmMachine.current_account_funds, dispensed: amount, new_amount: AtmMachine.current_account_balance } }
      rescue StandardError => e
        format.json{ render json: { error: true, message: e.message } }
      end
    end
  end

  def finish
    nullify_current_account
    redirect_to_login
  end

  # this is only for testing purposes. didn't even bother to write a test for this
  def refill
    AtmMachine.current_account.update balance: AtmMachine.current_account_balance + 1000
    respond_to do |format|
      format.json{ render json: {success: true, new_balance: AtmMachine.current_account_funds } }
    end
  end

  private
  def redirect_to_login
    redirect_to welcome_url
  end

  def authenticate_user
    AtmMachine.authenticate(params[:number], params[:pin])
    session[:current_account] = AtmMachine.current_account.id
  end

  def verify_current_account
    redirect_to_login and return unless current_account
    @current_account = BankAccount.find current_account
  end

  def nullify_current_account
    AtmMachine.current_account = nil
    session[:current_account] = nil
  end
end
