class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id, :ingredient_id
      t.float :quantity
      t.string :unit
      t.timestamps
    end
  end
end
