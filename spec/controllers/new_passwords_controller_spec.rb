require 'rails_helper'

describe NewPasswordsController do
  describe "GET show" do
    context "valid token" do
      it "sets the @token variable" do
        dan = Fabricate(:user)
        dan.assign_token
        get :show, params: { id: dan.reload.token }
        expect(assigns(:token)).to eq(dan.token)
      end
    end
    
    context "invalid token" do
      it "redirects to the expired token page" do
        dan = Fabricate(:user)
        dan.assign_token
        get :show, params: { id: "invalid_token" }
        expect(response).to redirect_to expired_token_path
      end
    end
  end
  
  describe "POST create" do
    it "redirects to the expired token page if token is invalid" do
      dan = Fabricate(:user)
      dan.assign_token
      post :create, params: { id: "invalid_token", password: "new_password" }
      expect(response).to redirect_to expired_token_path
    end
    
    context "with valid input" do
      let(:dan) { Fabricate(:user) }
      before do
        dan.assign_token
        post :create, params: { token: dan.reload.token, password: "new_password" }
      end
      
      it "sets updated password" do
        expect(dan.reload.authenticate("new_password")).to be_truthy
      end
      
      it "sets the flash success message" do
        expect(flash[:success]).not_to be_nil
      end
      
      it "removes the token from user" do
        expect(dan.reload.token).to be_nil
      end
    end
  end
end