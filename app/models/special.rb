class Special < ActiveRecord::Base
  has_many :grocery_specials
  validates_presence_of :name
  validates_uniqueness_of :name
end