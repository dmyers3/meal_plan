require 'rails_helper'

describe GroceryChain do
  it { should have_many(:grocery_products) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end