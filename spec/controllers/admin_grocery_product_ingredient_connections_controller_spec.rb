require 'rails_helper'

describe Admin::GroceryProductIngredientConnectionsController do
  let!(:chicken) { Fabricate(:ingredient) }
  let!(:harris_teeter) { Fabricate(:grocery_chain) }
  let!(:ht_chicken) { Fabricate(:grocery_product, grocery_chain: harris_teeter) }
  
  describe "POST create" do
    let(:name) { { name: { "#{ht_chicken.id}" => chicken.name }} }
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, params: name }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :create, params: name }
    end
    
    it "redirects to the grocery products index" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      post :create, params: name
      expect(response).to redirect_to admin_grocery_products_path
    end
    
    it "creates connection between ingredient and grocery product" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      post :create, params: name
      expect(ht_chicken.reload.ingredient).to eq(chicken)
    end
  end
  
  describe "DELETE destroy" do
    before do
      ht_chicken.ingredient = chicken
      ht_chicken.save
    end
    
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, params: { id: ht_chicken.id }}
    end
    
    it_behaves_like "requires admin" do
      let(:action) { delete :destroy, params: { id: ht_chicken.id }}
    end
    
    it "redirects to the grocery products index" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      delete :destroy, params: { id: ht_chicken.id }
      expect(response).to redirect_to admin_grocery_products_path
    end
    
    it "removes the connection between ingredient and grocery product" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      delete :destroy, params: { id: ht_chicken.id }
      expect(ht_chicken.reload.ingredient).to be_nil
    end
  end
end