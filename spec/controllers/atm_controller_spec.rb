require 'rails_helper'

RSpec.describe AtmController, :type => :controller do

  let(:user){ create(:user) }
  let(:bank_account){ create(:bank_account, user: user) }
  let(:valid_card){ create(:valid_card, bank_account: bank_account) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST authenticate' do
    it "redirects to login if invalid credentials" do
      post :authenticate, { number: 1111, pin: 2222 }
      expect(response).to redirect_to(welcome_path)
    end

    it 'renders index template if valid credentials are passed' do

      post :authenticate, { number: valid_card.number, pin: valid_card.pin }
      expect(response).to render_template('index')
    end
  end

end
