class Card < ActiveRecord::Base
  belongs_to :bank_account, dependent: :destroy

  scope :credit, ->{ where(type: :credit) }
  scope :debit, ->{ where(type: :debit) }

  delegate :user, to: :bank_account

  validates :number, numericality: { only_integer: true }, length: { is: 4 }
  validates :number, uniqueness: true
  validates :pin, numericality: { only_integer: true }, length: { is: 4 }

  def expired?
    Date.today > expiration_date
  end
end
