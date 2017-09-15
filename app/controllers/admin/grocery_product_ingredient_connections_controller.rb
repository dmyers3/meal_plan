class Admin::GroceryProductIngredientConnectionsController < AdminsController
  def create
    params[:name].each do |id, ing_name|
      if ing_name != ""
        grocery_product = GroceryProduct.find(id.to_i)
        ingredient = Ingredient.find_by(name: ing_name)
      end
      if ingredient
        grocery_product.ingredient = ingredient
        grocery_product.save
      end
    end
    redirect_to admin_grocery_products_path
  end
  
  def destroy
    grocery_product = GroceryProduct.find(params[:id])
    if grocery_product
      grocery_product.ingredient = nil
      grocery_product.save
    end
    redirect_to admin_grocery_products_path
  end
end