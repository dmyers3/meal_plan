require 'rails_helper'

describe Admin::RecipesController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { get :new }
    end
    
    it "sets @recipe" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      get :new
      expect(assigns(:recipe)).to be_a(Recipe)
    end
  end
  
  describe "POST create" do
    let(:recipe_params) { Fabricate.attributes_for(:recipe) }
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, params: { recipe: { name: recipe_params[:name],
        prep_time: recipe_params[:prep_time], cook_time: recipe_params[:cook_time],
        instructions: recipe_params[:instructions]
      }}}
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :create, params: { recipe: { name: recipe_params[:name],
        prep_time: recipe_params[:prep_time], cook_time: recipe_params[:cook_time],
        instructions: recipe_params[:instructions]
      }}}
    end
    
    context "with valid input" do
      before do
        dan = Fabricate(:admin)
        session[:user_id] = dan.id
        cat1 = Fabricate(:tag_category)
        cat2 = Fabricate(:tag_category)
        cat3 = Fabricate(:tag_category)
        post :create, params: { recipe: { name: recipe_params[:name], 
          prep_time: recipe_params[:prep_time], cook_time: recipe_params[:cook_time],
          instructions: recipe_params[:instructions], 
          tag_categories: [cat1.id, cat2.id]}, new_tags: "New, tag"}
      end
      
      # it "creates a recipe" do
      #   expect(Recipe.count).to eq(1)
      # end
      
    #   it "creates new tag categories" do
    #     expect(TagCategory.count).to eq(5)
    #   end
      
    #   it "downcases tag categories" do
    #     expect(TagCategory.find_by(name: 'new')).to be_a(TagCategory)
    #   end
      
    #   it "strips tag categories of whitespace" do
    #     expect(TagCategory.find_by(name: 'tag')).to be_a(TagCategory)
    #   end
      
    #   it "creates tags belonging to ingredient" do
    #     expect(Ingredient.last.tags.count).to eq(4)
    #   end
      
    #   it "redirects to the new admin ingredient path" do
    #     expect(response).to redirect_to new_admin_ingredient_path
    #   end
      
    #   it "sets a flash success message" do
    #     expect(flash[:success]).not_to be_empty
    #   end
    end
    
    # context "with invalid input" do
    #   before do
    #     dan = Fabricate(:admin)
    #     session[:user_id] = dan.id
    #     cat1 = Fabricate(:tag_category)
    #     post :create, params: { ingredient: { name: ""}, new_tags: "new"}
    #   end
      
    #   it "doesn't create an ingredient" do
    #     expect(Ingredient.count).to eq(0)
    #   end
      
    #   it "sets a flash error message" do
    #     expect(flash[:error]).not_to be_empty
    #   end
      
    #   it "renders the new ingredient form" do
    #     expect(response).to render_template :new
    #   end
      
    #   it "doesn't create a new tag_category" do
    #     expect(TagCategory.count).to eq(1)
    #   end
    # end
    
    # context "with no tags attached" do
    #   before do
    #     dan = Fabricate(:admin)
    #     session[:user_id] = dan.id
    #     cat1 = Fabricate(:tag_category)
    #     post :create, params: { ingredient: { name: ingredient_params[:name]}, new_tags: "  "}
    #   end
      
    #   it "creates an ingredient" do
    #     expect(Ingredient.count).to eq(1)
    #   end
      
    #   it "doesn't create new tag categories" do
    #     expect(TagCategory.count).to eq(1)
    #   end
      
    #   it "doesn't create any tag associations for ingredient" do
    #     expect(Ingredient.last.tags.size).to eq(0)
    #     expect(Ingredient.last.tag_categories.size).to eq(0)
    #   end
    # end
  end
end