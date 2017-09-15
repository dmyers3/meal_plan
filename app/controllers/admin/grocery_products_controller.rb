class Admin::GroceryProductsController < AdminsController
  skip_before_action :verify_authenticity_token, :only => [:update]
  skip_before_action :redirect_logged_out, :only => [:update]
  skip_before_action :redirect_non_admin, :only => [:update]
  
  def index
    @grocery_products = GroceryProduct.order("name").page(params[:page])
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