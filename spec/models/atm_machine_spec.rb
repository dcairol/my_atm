require 'rails_helper'

RSpec.describe AtmMachine, type: :class do

  let(:user){ create(:user) }
  let(:bank_account){ create(:bank_account, user: user) }
  let(:valid_card){ create(:valid_card, bank_account: bank_account) }

  subject{ AtmMachine }

  describe 'Authentication' do

    after(:all){ AtmMachine.finish_transactions }

    it 'rejects card number and card pin if they are wrong' do
      expect{ subject.authenticate(1234, 1233) }.to raise_error(InvalidAccessError, "Invalid Credentials.")
    end

    it 'rejects the card if expired' do
      expired_card = create(:expired_card)
      expect{ subject.authenticate(expired_card.number, expired_card.pin) }.to raise_error(InvalidAccessError, "Your card has expired.")
    end

    it 'grants the user with correct credentials access to his/her account' do
      subject.authenticate(valid_card.number, valid_card.pin)
      expect(subject.current_account).to eq(bank_account)
    end
  end

  describe 'Money Withdraw' do

    after(:all){ AtmMachine.finish_transactions }

    it 'rejects the request if user not authenticated' do
      expect{ subject.withdraw }.to raise_error(InvalidAccessError, "There isn't a valid user logged in.")
    end

    it 'accepts the request if user is authenticated' do
      authenticate
      expect{ subject.withdraw }.not_to raise_error
    end

    it 'dispenses the requested amount and changes the balance in the bank account if enough funds available' do
      to_withdraw = subject.current_account_balance - 500
      expect{ subject.withdraw(to_withdraw) }.to change{ subject.current_account_balance }.by(-to_withdraw)
    end

    it 'raises an error if the requested amount is bigger than the available amount' do
      to_withdraw = subject.current_account_balance + 1
      expect{ subject.withdraw(to_withdraw) }.to raise_error(NotEnoughFunds)
    end

    it 'raises an error if the requested amount is not a number' do
      a_string = "a string"
      expect{ subject.withdraw(a_string) }.to raise_error(NotANumberError,"not a number")
    end
  end

  describe 'Transaction Finalisation' do

    it 'Logs the user out' do
      subject.authenticate(valid_card.number, valid_card.pin)
      subject.finish_transactions
      expect(subject.current_account).to be_nil
    end
  end

  private
  def authenticate
    AtmMachine.authenticate(valid_card.number, valid_card.pin)
  end
end
