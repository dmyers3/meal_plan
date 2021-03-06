require 'rails_helper'

describe TagCategory do
  it { should validate_presence_of(:name) }
  it { should have_many(:tags) }
  it { should validate_uniqueness_of(:name) }
end