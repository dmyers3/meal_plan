class CreateGrocerySpecials < ActiveRecord::Migration[5.1]
  def change
    create_table :grocery_specials do |t|
      t.integer :grocery_product_id, :special_id, :minimum_quantity
      t.datetime :start_date, :end_date
      t.timestamps
    end
  end
end
