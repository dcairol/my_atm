require 'rails_helper'

RSpec.describe AtmController, :type => :controller do

  let(:user){ create(:user) }
  let(:bank_account){ create(:bank_account, user: user) }
  let(:valid_card){ create(:valid_card, bank_account: bank_account) }
  let(:exceeded_amount){ bank_account.balance + 1 }

  describe 'POST authenticate' do

    describe 'with invalid credentials' do

      it "redirects to login" do
        post :authenticate, { number: 1111, pin: 2222 }
        expect(response).to redirect_to(welcome_path)
      end

      it "sets an authentication error message" do
        post :authenticate, { number: 1111, pin: 2222 }
        expect(request.flash[:error]).to eq("Invalid Credentials.")
      end
    end

    describe 'with valid credentials' do
      it 'renders index template if valid credentials are passed' do
        post :authenticate, { number: valid_card.number, pin: valid_card.pin }
        expect(response).to redirect_to(atm_path)
      end
    end
  end

  describe 'POST withdraw' do
    describe 'when there are errors' do
      it 'renders a json containing the error key and the error message' do
        post :withdraw, {amount: exceeded_amount, format: :json}, {current_account: bank_account.id}
        hash = parse_json response.body
        %w{ error message }.each{|key| expect(hash[key]).to be_truthy }
      end
    end

    describe 'when successfully processed' do
      it 'renders a json with the success key set to true, the current account balance and the dispensed amount' do
        post :withdraw, { amount: 10, format: :json }, { current_account: bank_account.id }
        hash = parse_json response.body
        %w{ success new_balance dispensed }.each{|key| expect(hash[key]).to be_truthy }
      end
    end
  end

  describe 'POST finish' do
    it 'redirects the user to the login page' do
      post :finish, {}, {current_account: bank_account.id}
      expect(response).to redirect_to(welcome_path)
    end
  end

  private
  def parse_json(json)
    JSON.parse(json)
  end

end
