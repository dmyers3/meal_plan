require 'rails_helper'

describe Tag do
  it { should validate_presence_of(:tag_category_id) }
  it { should validate_presence_of(:user_id) }
  it { should belong_to(:user) }
  it { should belong_to(:tag_category) }
end