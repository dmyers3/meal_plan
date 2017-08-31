class GroceryChain < ActiveRecord::Base
  has_many :grocery_products
  validates_presence_of :name
  validates_uniqueness_of :name
end