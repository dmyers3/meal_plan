require 'rails_helper'

describe TagCategory do
  it { should validate_presence_of(:name) }
  it { should have_many(:tags) }
end