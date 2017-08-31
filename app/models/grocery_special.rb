class GrocerySpecial < ActiveRecord::Base
  belongs_to :grocery_product
  belongs_to :special
  validates_presence_of :grocery_product_id, :special_id, :start_date, :end_date, :minimum_quantity

end