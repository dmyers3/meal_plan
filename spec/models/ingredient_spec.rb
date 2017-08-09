require 'rails_helper'

describe Ingredient do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:recipe_ingredients) }
  it { should have_many(:recipes) }
  it { should have_many(:tags).dependent(:destroy) }
  it { should have_many(:tag_categories) }
end