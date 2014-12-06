require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  it{ should(belong_to(:user)) }
  it{ should(have_one(:card)) }

  it 'can be in dollars' do
    account = build(:bank_account)
    expect(account).to be_in_dollars
  end

  it 'can be in colones' do
    account_in_colones = build(:bank_account_in_colones)
    expect(account_in_colones).to     be_in_colones
    expect(account_in_colones).not_to be_in_dollars
  end
end
