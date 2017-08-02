require 'rails_helper'

describe UsersController do
  describe "GET front" do
    it_behaves_like "requires signed out" do
      let(:action) { get :front }
    end
  end
  
  describe "GET new" do
    it "sets @user if not logged in" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
    
    it_behaves_like "requires signed out" do
      let(:action) { get :new }
    end
  end
  
  describe "POST create" do
    it_behaves_like "requires signed out" do
      let(:action) { post :create }
    end
    
    context "with valid input" do
      before { post :create, params: { user: Fabricate.attributes_for(:user) } }
      
      it "creates a user" do
        expect(User.count).to eq(1)
      end
      
      it "redirects to the home path" do
        expect(response).to redirect_to new_user_subscription_path(User.last)
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
    
    context "sending emails" do
      let(:user_attributes) { Fabricate.attributes_for(:user) }
      before do
        AppMailer.deliveries.clear
        post :create, params: { user: user_attributes }
      end
      
      it "sends an email after creating user" do
        expect(AppMailer.deliveries.count).to eq(1)
      end
      
      it "sends an email to the right user" do
        expect(AppMailer.deliveries.last.to).to eq([user_attributes['email']])
      end
      
      it "includes a welcome message" do
        expect(AppMailer.deliveries.last.body).to include('Welcome')
      end
    end
  end
  
  describe "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show }
    end
    
  end
end