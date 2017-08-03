class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :tags, as: :taggable
  validates :name, presence: true, uniqueness: true
end