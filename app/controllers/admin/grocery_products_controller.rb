class Admin::GroceryProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:update]
  
  def index
    @grocery_products = GroceryProduct.order("name").page(params[:page])
    options = {}
    # if params[:name]
    #   @ingredients = Ingredient.search(params[:name], options).records.to_a
    # end
  end
  
  def update
    if params[:priceToken] != ENV["PRICE_TOKEN"]
      head :unauthorized
    else
      GroceryProduct.parse(params)
      head :ok
    end
  end
end