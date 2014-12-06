require 'rails_helper'

RSpec.describe AtmMachine, type: :model do
  describe 'verifies user credentials' do

    before(:all){ @atm = AtmMachine.new }
    subject{ @atm }
    let(:user){ build(:user) }
    let(:bank_account){ build(:bank_account, user: user) }

    it 'rejects card number and card pin in case they are wrong' do
      expect{ subject.verify_credentials(1234, 1233) }.to raise_error(InvalidAccessError, "Invalid Credentials.")
    end

    it 'rejects card if expired' do
      expired_card = create(:expired_card)
      expect{ subject.verify_credentials(expired_card.number, expired_card.pin) }.to raise_error(InvalidAccessError, "Your card has expired.")
    end

    it 'grants the user access to his/her account in case if credentials are correct' do
      valid_card = create(:valid_card, bank_account: bank_account)
      expect(subject.verify_credentials(valid_card.number, valid_card.pin)).to be_truthy
    end
  end

  describe 'takes requests to withdraw money' do
    
  end
end
