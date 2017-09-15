require 'rails_helper'

describe Admin::GroceryProductsController do
  describe "PUT update" do
    it "returns unauthorized if price token is invalid" do
      put :update, params: { priceToken: "invalidToken" }
      expect(response.status).to eq(401)
    end
    
    context "with valid input" do
      before do
        put :update, params: { priceToken: ENV["PRICE_TOKEN"] }
      end
      
      it "returns status 200 if price token is valid" do
        expect(response.status).to eq(200)
      end
    end
  end
  
  describe "GET index" do
    let(:harris_teeter) { Fabricate(:grocery_chain) }
    let(:milk) { Fabricate(:grocery_product, name: "milk", grocery_chain: harris_teeter) }
    let(:bread) { Fabricate(:grocery_product, name: "bread", grocery_chain: harris_teeter) }
    
    it "redirects non admin to root page" do
      get :index
      expect(response).to redirect_to root_path
    end
    
    it "sets @grocery_products instance variable sorted alphabetically" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      get :index
      expect(assigns(:grocery_products)).to eq([bread, milk])
    end
  end
end