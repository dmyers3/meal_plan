require 'rails_helper'

describe GrocerySpecial do
  it { should belong_to(:grocery_product) }
  it { should belong_to(:special) }
  it { should validate_presence_of(:grocery_product_id) }
  it { should validate_presence_of(:special_id) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should validate_presence_of(:minimum_quantity) }
end