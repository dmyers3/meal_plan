class MealPlanRecipe < ActiveRecord::Base
  belongs_to :meal_plan
  belongs_to :recipe
  validates_presence_of :meal_plan_id, :recipe_id
end