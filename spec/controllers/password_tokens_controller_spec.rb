require 'rails_helper'

describe PasswordTokensController do
  describe "GET new" do
    it_behaves_like "requires signed out" do
      let(:action) { get :new }
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires signed out" do
      let(:action) { post :create }
    end
    
    context "with valid email" do
      it "redirects to the confirm reset password page" do
        @dan = Fabricate(:user)
        post :create, params: { email: @dan.email }
        expect(response).to redirect_to confirm_reset_password_path
      end
    end
  end
end

