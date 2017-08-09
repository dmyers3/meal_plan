class Admin::IngredientsController < AdminsController
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.name.downcase!
    if @ingredient.save
      assign_tags(@ingredient)
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
  
  def assign_tags(ingredient)
    params[:ingredient][:tag_categories] ||= []
    # start array of category id's from selected tag categories
    tag_category_ids = params[:ingredient][:tag_categories].map(&:to_i)
   
    # create new tag categories and push their id's to array
    new_tags = params[:new_tags].split(",").map(&:strip).map(&:downcase)
    new_tags.each do |tag_name|
      new_category = TagCategory.create(name: tag_name)
      tag_category_ids << new_category.id
    end
    
    # iterate through all the category id's and create tag's associated with the ingredient
     tag_category_ids.each do |category_id|
      Tag.create(tag_category_id: category_id.to_i, taggable_type: "Ingredient",
                 taggable_id: ingredient.id, user_id: current_user.id)
    end
  end
end