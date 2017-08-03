class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  validates_presence_of :recipe_id, :ingredient_id, :quantity, :unit
end