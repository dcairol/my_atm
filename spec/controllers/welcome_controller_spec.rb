require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do

  let(:bank_account){ create(:bank_account) }

  describe "GET index" do
    describe "not being authenticated" do
      it 'should render the welcome template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "being authenticated" do

      it 'should redirect to the Atm' do
        session[:current_account] = bank_account.id
        AtmMachine.current_account = bank_account
        get(:index)
        expect(response).to redirect_to(atm_path)
        session[:current_account] = nil
      end
    end
  end

end
