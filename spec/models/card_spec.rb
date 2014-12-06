require 'rails_helper'

RSpec.describe Card, type: :model do
  it{ should(belong_to(:bank_account)) }

  it 'is marked as expired if expiration date is in the past' do
    expect(build(:expired_card)).to be_expired
  end

  it 'is not expired if expiration date is in the past' do
    expect(build(:valid_card)).not_to be_expired
  end

  it 'has access to the user who owns the bank account' do
    user = build(:user)
    bank_account = build(:bank_account, user: user)
    card = build(:valid_card, bank_account: bank_account)
    expect(card.user).to eq(user)
  end
end
