class CreateMealPlanRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_plan_recipes do |t|
      t.integer :meal_plan_id, :recipe_id
      t.timestamps
    end
  end
end
