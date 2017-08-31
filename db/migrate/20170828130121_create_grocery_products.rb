class CreateGroceryProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :grocery_products do |t|
      t.integer :ingredient_id, :grocery_store_chain_id
      t.string :name, :unit
      t.float :quantity, :reg_price, :current_price
      t.timestamps
    end
  end
end
