require 'rails_helper'

describe SubscriptionsController do
  describe "GET new" do
    let(:alice) { Fabricate(:user) }
    
    it_behaves_like "requires sign in" do
      let(:action) { get :new, params: {user_id: alice.id } }
    end
    
    it_behaves_like "requires correct user" do
      let(:action) { get :new, params: {user_id: alice.id } }
    end
    
    it "sets @user to the current user" do
      session[:user_id] = alice.id
      get :new, params: { user_id: alice.id }
      expect(assigns(:user)).to eq(alice)
    end
  end
  
  describe "POST create" do
    let(:alice) { Fabricate(:user) }
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, params: {user_id: alice.id } }
    end
    
    it_behaves_like "requires correct user" do
      let(:action) { post :create, params: {user_id: alice.id } }
    end
  end
end