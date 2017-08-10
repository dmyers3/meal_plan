class Ingredient < ActiveRecord::Base
  include Taggable
  
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :tag_categories, through: :tags
  validates :name, presence: true, uniqueness: true
  default_scope { order(name: :asc) }
end