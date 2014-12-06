class User < ActiveRecord::Base
  has_many :bank_accounts
  has_many :cards, through: :bank_accounts
end
