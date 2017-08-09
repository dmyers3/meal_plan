class TagCategory < ActiveRecord::Base
  has_many :tags
  validates_presence_of :name
  validates_uniqueness_of :name
  default_scope { order(name: :asc) }
end