require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
    
    it_behaves_like "requires signed out" do
      let(:action) { get :new }
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires signed out" do
      let(:action) { post :create }
    end
    
    context "with valid credentials" do
      before do 
        @dan = Fabricate(:user)
        post :create, params: { email: @dan.email, password: @dan.password }
      end
      
      it "puts the signed in user in the session" do
        expect(session[:user_id]).to eq(@dan.id)
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end
    
    context "with invalid credentials" do
      before do
        @dan = Fabricate(:user)
        post :create, params: { email: @dan.email, password: "sadklsaf" }
      end
      
      it "gives error message" do
        expect(flash[:error]).not_to be_blank
      end
      
      it "does not put the signed in user in the session" do
        expect(session[:user_id]).to eq(nil)
      end
      
      it "renders the login page" do
        expect(response).to render_template :new
      end
    end
  end
  
  describe "GET destroy" do
    it "clears the session for the user" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to be_nil
    end
    
    it "redirects to the root path" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end