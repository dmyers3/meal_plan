require 'rails_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user if not logged in" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end
  
  describe "POST create" do
    context "with valid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user) } }
      
      it "creates a user" do
        expect(User.count).to eq(1)
      end
      
      it "redirects to the home path" do
        expect(response).to redirect_to home_path
      end
      
      it "sets the flash success message" do
        expect(flash[:success]).not_to be_empty
      end
    end
    
    context "with invalid input" do
      before { post :create, params: { user: { email: "dan@example.com", zip_code: "12345" }}}
      
      it "doesn't create a user" do
        expect(User.count).to eq(0)
      end
      
      it "renders the new user page" do
        expect(response).to render_template :new
      end
      
      it "sets a flash error message" do
        expect(flash[:error]).not_to be_empty
      end
      
      it "sets @user" do
        expect(assigns(:user)).to be_a(User)
      end
    end
  end
end