class Admin::IngredientsController < AdminsController
  
  def index
    @ingredients = Ingredient.all
  end
  
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
  
  def autocomplete
    render json: Ingredient.search(params[:query], {
      fields: ["name"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    })
  end
  
  private
  
  def ingredient_params
    params.require(:ingredient).permit(:name)
  end
end