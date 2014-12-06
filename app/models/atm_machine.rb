class AtmMachine < ActiveRecord::Base

  attr_accessor :current_user

  def finish_using
    current_user = nil
  end

  def verify_credentials(card_number, pin)
    card = Card.where(number: card_number, pin: pin).includes(bank_account: [:user]).first
    raise_invalid_credentials unless card
    raise_expired_card if card.expired?
    current_user = card.user
    true
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

  def ask_to_finish
    "Please finish your current transaction before starting a new one."
  end

  def show_welcome_message
    @being_used = true
    "Welcome! Please enter your credentials."
  end

  def being_used?
    @being_used
  end

end

class InvalidAccessError < StandardError; end