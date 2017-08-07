require 'rails_helper'

describe MealPlanRecipe do
  it { should validate_presence_of(:meal_plan_id) }
  it { should validate_presence_of(:recipe_id) }
  it { should belong_to(:meal_plan) }
  it { should belong_to(:recipe) }
end