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
    
    context "with invalid email" do
      let(:dan) { Fabricate(:user) }
      before { post :create, params: { email: "incorrectemail@example.com" }}
      it "sets an error message" do
        expect(flash[:error]).not_to be_nil
      end
      
      it "renders the reset password form" do
        expect(response).to render_template :new
      end
    end
    
    context "with empty email" do
      let(:dan) { Fabricate(:user) }
      before { post :create, params: { email: "" }}
      
      it "sets an error message" do
        expect(flash[:error]).not_to be_nil
      end
      
      it "renders the reset password form" do
        expect(response).to render_template :new
      end
    end
  end
end

