require 'rails_helper'

describe Special do
  it { should have_many(:grocery_specials) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end