class GroceryProduct < ActiveRecord::Base
  belongs_to :grocery_chain
  belongs_to :ingredient, optional: true
  has_many :grocery_specials
  validates_presence_of :name, :quantity, :unit, :reg_price
  
  def self.parse(params)
    if params["source"] == "Harris Teeter"
      parseHarrisTeeter(params["ingredients"])
    end
  end
  
  private
    def self.parseHarrisTeeter(ingredients)
      ingredients.each do |index, ingredient|
        ing_name = ingredient["name"].strip
        ing_quantity = ingredient["size"].split(" ", 2).first
        ing_unit = ingredient["size"].split(" ", 2).last
        ing_current_price = (ingredient["current_price"].split("$").last.to_f * 100).to_i
        ing_regular_price = ingredient["regular_price"] == "" ? ing_current_price : (ingredient["regular_price"].split("$").last.to_f * 100).to_i
        existing_product = GroceryProduct.find_by(name: ing_name, quantity: ing_quantity, unit: ing_unit)
        if existing_product
          existing_product.update_columns(current_price: ing_current_price, reg_price: ing_regular_price)
        else
          product = GroceryProduct.create(name: ing_name, quantity: ing_quantity, unit: ing_unit,
            current_price: ing_current_price, reg_price: ing_regular_price, 
            grocery_chain: GroceryChain.find_by(name: "Harris Teeter"))
        end
      end
        
      
    end
    
end