class MealPlanCategory < ActiveRecord::Base
  has_many :meal_plans
  validates_presence_of :name
end