class AtmMachine < ActiveRecord::Base

  attr_accessor :current_account

  def finish_transactions
    @current_account = nil
  end

  def authenticate(card_number, pin)
    card = Card.where(number: card_number, pin: pin).includes(bank_account: [:user]).first
    raise_invalid_credentials unless card
    raise_expired_card if card.expired?
    @current_account = card.bank_account
  end

  def withdraw(amount=0)
    raise_not_a_number unless amount.is_a? Integer
    raise_user_not_logged_in unless @current_account
    @current_account.dispense(amount)
  end

  def current_account_balance
    current_account.try(:balance)
  end

  def current_account_funds
    current_account.try(:current_funds)
  end

  private
  def raise_invalid_credentials
    raise InvalidAccessError, "Invalid Credentials."
  end

  def raise_expired_card
    raise InvalidAccessError, "Your card has expired."
  end

  def raise_user_not_logged_in
    raise InvalidAccessError, "There isn't a valid user logged in."
  end

  def raise_not_a_number
    raise NotANumberError, "not a number"
  end

  def account_has_no_funds?
    !current_account.has_funds?
  end

end

class InvalidAccessError < StandardError; end