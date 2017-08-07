require 'rails_helper'

describe MealPlanCategory do
  it { should validate_presence_of(:name) }
  it { should have_many(:meal_plans) }
end