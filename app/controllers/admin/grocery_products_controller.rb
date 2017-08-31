class Admin::GroceryProductsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:update]
  
  def update
    if params[:priceToken] != ENV["PRICE_TOKEN"]
      head :unauthorized
    else
      GroceryProduct.parse(params)
      head :ok
    end
  end
end