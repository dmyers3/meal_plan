class ChangeGroceryProductsColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :grocery_products, :grocery_store_chain_id, :grocery_chain_id
  end
end
