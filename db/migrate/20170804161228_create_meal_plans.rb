class CreateMealPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :meal_plans do |t|
      t.integer :meal_plan_category_id, :user_id
      t.date :date
      t.timestamps
    end
  end
end
