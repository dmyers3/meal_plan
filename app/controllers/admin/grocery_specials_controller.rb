class Admin::GrocerySpecialsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  
  def create
    if params[:priceToken] != ENV["PRICE_TOKEN"]
      head :unauthorized
    else
      head :ok
    end
  end
end