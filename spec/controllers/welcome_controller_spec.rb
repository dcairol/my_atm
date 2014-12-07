require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do

  describe "GET index" do
    describe "not being authenticated" do
      it 'should render the welcome template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe "being authenticated" do
      it 'should redirect to the Atm' do
        session[:current_account] = 1
        get(:index)
        expect(response).to redirect_to(atm_path)
        session[:current_account] = nil
      end
    end
  end

end
