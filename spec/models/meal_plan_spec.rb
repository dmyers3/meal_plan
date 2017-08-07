require 'rails_helper'

describe MealPlan do
  it { should validate_presence_of :meal_plan_category_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :date }
  it { should belong_to(:user) }
  it { should belong_to(:meal_plan_category) }
  it { should have_many(:meal_plan_recipes) }
  it { should have_many(:recipes) }
  
end