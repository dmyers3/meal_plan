class Recipe < ActiveRecord::Base
  include Taggable
  
  belongs_to :user
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true, reject_if: :all_blank
  has_many :ingredients, through: :recipe_ingredients
  has_many :tags, as: :taggable
  has_many :tag_categories, through: :tags
  has_many :meal_plan_recipes
  has_many :meal_plans, through: :meal_plan_recipes
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  default_scope { order(name: :asc) }
  
  def attach_ingredients(params)
    ingredients = params[:ing_id].map(&:to_i).map do |id|
      Ingredient.find(id)
    end
    units = params[:unit]
    quantities = params[:quantity].map(&:to_f)
    ingredients.each_with_index do |ingredient, index|
      RecipeIngredient.create(recipe_id: id, ingredient_id: ingredient.id,
                               quantity: quantities[index], unit: units[index])
    end
  end
end