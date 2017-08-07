class MealPlan < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal_plan_category
  has_many :meal_plan_recipes
  has_many :recipes, through: :meal_plan_recipes
  
  validates_presence_of :user_id, :meal_plan_category_id, :date
end