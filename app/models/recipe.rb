class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :tags, as: :taggable
  has_many :tag_categories, through: :tags
  has_many :meal_plan_recipes
  has_many :meal_plans, through: :meal_plan_recipes
  validates :name, presence: true, uniqueness: true
end