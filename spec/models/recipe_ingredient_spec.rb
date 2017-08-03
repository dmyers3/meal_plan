require 'rails_helper'

describe RecipeIngredient do
  it { should validate_presence_of(:recipe_id) }
  it { should validate_presence_of(:ingredient_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit) }
  it { should belong_to(:recipe) }
  it { should belong_to(:ingredient) }
end