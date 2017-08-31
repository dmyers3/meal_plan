class CreateGroceryChains < ActiveRecord::Migration[5.1]
  def change
    create_table :grocery_chains do |t|
      t.string :name
      t.timestamps
    end
  end
end
