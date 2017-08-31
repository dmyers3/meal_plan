require 'rails_helper'

describe GroceryProduct do
  it { should belong_to(:grocery_chain) }
  it { should have_many(:grocery_specials) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit) }
  it { should validate_presence_of(:reg_price) }
  
  describe "::parse" do
    context "with Harris Teeter source" do
      it "creates new products if their information doesn't already exist" do
        expect(GroceryProduct.all.size).to eq(0)
        Fabricate(:grocery_chain, name: "Harris Teeter")
        params = {"priceToken"=>ENV["PRICE_TOKEN"], 
          "ingredients"=>{"0"=>{"name"=>"HT Fresh Foods Market Quiche - Lorraine", 
          "size"=>"1 ct", "current_price"=>"$9.99", "regular_price"=>"", "sale_info"=>""}, 
          "1"=>{"name"=>"HT Fresh Foods Market Quiche - Spinach & Cheese", "size"=>"1 ct",
          "current_price"=>"$9.99", "regular_price"=>"", "sale_info"=>""}, 
          "2"=>{"name"=>"HT Fresh Foods Market Roasted Boneless Turkey Breast", 
          "size"=>"16 oz", "current_price"=>"$9.99", "regular_price"=>"", "sale_info"=>""}}, 
          "source"=>"Harris Teeter"}
        GroceryProduct.parse(params)
        expect(GroceryProduct.all.size).to eq(3)
      end
      
      it "updates product if it already exists" do
        harris_teeter = Fabricate(:grocery_chain, name: "Harris Teeter")
        bread = Fabricate(:grocery_product, grocery_chain: harris_teeter)
        params = {"priceToken"=>ENV["PRICE_TOKEN"], 
          "ingredients"=>{"0"=>{"name"=>bread.name, "size"=>"#{bread.quantity} #{bread.unit}", 
          "current_price"=>"$9.99", "regular_price"=>"", "sale_info"=>""}},
          "source"=>"Harris Teeter"}
        GroceryProduct.parse(params)
        expect(bread.reload.current_price).to eq(999)
      end
    end
  end
end