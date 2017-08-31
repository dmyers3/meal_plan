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
end