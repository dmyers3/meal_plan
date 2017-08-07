class CreateMealPlanCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_plan_categories do |t|
      t.string :name
      t.timestamps
    end
  end
end
