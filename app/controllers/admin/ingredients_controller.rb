class Admin::IngredientsController < AdminsController
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.name.downcase!
    if @ingredient.save
      @ingredient.attach_tags(params, current_user.id)
      flash[:success] = "Ingredient added!"
      redirect_to new_admin_ingredient_path
    else
      flash[:error] = "Ingredient not added."
      render 'new'
    end
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end