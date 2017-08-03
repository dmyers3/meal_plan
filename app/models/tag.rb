class Tag < ActiveRecord::Base
  belongs_to :user
  belongs_to :taggable, polymorphic: true
  belongs_to :tag_category
  
  validates_presence_of :user_id, :tag_category_id
end