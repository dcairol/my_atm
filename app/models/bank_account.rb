class BankAccount < ActiveRecord::Base

  belongs_to :user
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
end
