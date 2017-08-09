require 'rails_helper'

describe Recipe do
  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:recipe_ingredients) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:ingredients) }
  it { should have_many(:tags) }
  it { should have_many(:tag_categories) }
  it { should have_many(:meal_plan_recipes) }
  it { should have_many(:meal_plans) }
end