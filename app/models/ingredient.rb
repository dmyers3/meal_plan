class Ingredient < ActiveRecord::Base
  include Taggable
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  
  # index_name ["meal_plan", Rails.env].join('_')
  
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :tag_categories, through: :tags
  has_many :grocery_products
  validates :name, presence: true, uniqueness: true
  default_scope { order(name: :asc) }
  
  searchkick word_start: [:name]
  
  # def self.search(query, options={})
  #   search_definition = {
  #     query: {
  #       bool: {
  #         must: {
  #           multi_match: {
  #             query: query,
  #             fields: ["name"],
  #           }
  #         }
  #       }
  #     }
  #   }
  #   __elasticsearch__.search(search_definition)
  # end
  
  # elasticsearch method
  def as_indexed_json(options={})
    as_json(only: [:name])
  end
end