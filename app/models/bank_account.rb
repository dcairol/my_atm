class BankAccount < ActiveRecord::Base

  belongs_to :user, dependent: :destroy
  belongs_to :currency
  has_one :card

  validates :number, numericality: { only_integer: true}, length: { is: 6 }
  validates :number, uniqueness: true

  def in_dollars?
    currency.dollars?
  end

  def in_colones?
    currency.colones?
  end

  def has_funds?
    balance > 0
  end

  def has_enough?(amount)
    new_balance(amount) > 0
  end

  def dispense(amount)
    raise NotANumberError, "Not a number" unless amount.is_a? Integer
    raise NotEnoughFunds, "Not enough funds" unless has_enough?(amount)
    save_new_balance(amount)
    prepend_currency(amount)
  end

  def current_funds
    prepend_currency(balance)
  end

  private
  def save_new_balance(amount)
    self.balance = new_balance(amount)
    save
  end

  def new_balance(amount)
    balance - amount
  end

  def prepend_currency(amount)
    "#{currency.symbol}#{amount}"
  end
end

class NotEnoughFunds < StandardError; end
class NotANumberError < StandardError; end