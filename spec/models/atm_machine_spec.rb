require 'rails_helper'

RSpec.describe AtmMachine, type: :model do

  describe 'Start transaction' do
    before(:all){ @atm = AtmMachine.new }
    subject{ @atm }

    describe 'if not being used' do
      it 'displays a Welcome Message and suggests the user to enter his/her credentials' do
        expect(subject.start_using).to eq("Welcome! Please enter your credentials.")
      end

      it 'is marked as being used' do
        expect(subject.being_used).to be(true)
      end
    end

    describe 'if being used' do
      it 'asks the user to finish the current transaction' do
        expect(subject.start_using).to eq("Please finish your current transaction before starting a new one.")
      end
    end
  end

  describe 'Finish transaction' do

    before(:all){ @atm = AtmMachine.new; @atm.start_using; @atm.finish_using }
    subject{ @atm }

    it 'is available for use' do
      expect(subject.start_using).to eq("Welcome! Please enter your credentials.")
    end
  end

  describe 'verifies user credentials' do
    # it 'rejects user credentials in case they are wrong' do
    #   pending
    # end

    describe 'grants the user access to his/her account in case if credentials are correct' do
      pending
    end
  end

  describe 'takes requests to withdraw money' do
    pending
  end
end
