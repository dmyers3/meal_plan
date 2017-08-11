class Admin::RecipesController < AdminsController
  def index
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      @recipe.attach_ingredients(params)
      @recipe.attach_tags(params, current_user.id)
      flash[:success] = "Recipe added!"
      redirect_to new_admin_recipe_path
    else
      flash[:error] = "Recipe not added."
      render 'new'
    end
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :prep_time, :cook_time, :instructions)
  end
end