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
        chicken = Fabricate(:ingredient)
        rice = Fabricate(:ingredient)
        post :create, params: { 
          recipe: {
            name: recipe_params[:name], prep_time: recipe_params[:prep_time], 
            cook_time: recipe_params[:cook_time], instructions: recipe_params[:instructions],
            tag_categories: [cat1.id, cat2.id]
          }, 
          new_tags: "New, tag", ing_id: ["#{chicken.id}", "#{rice.id}"], 
          unit: ["lb", "c"], quantity: ["1", "2"]
        }
      end
      
      it "creates a recipe" do
        expect(Recipe.count).to eq(1)
        
      end
      
      it "creates new tag categories" do
        expect(TagCategory.count).to eq(5)
      end
      
      it "downcases tag categories" do
        expect(TagCategory.find_by(name: 'new')).to be_a(TagCategory)
      end
      
      it "strips tag categories of whitespace" do
        expect(TagCategory.find_by(name: 'tag')).to be_a(TagCategory)
      end
      
      it "creates tags belonging to recipe" do
        expect(Recipe.last.tags.count).to eq(4)
      end
      
      it "redirects to the new admin recipe path" do
        expect(response).to redirect_to new_admin_recipe_path
      end
      
      it "sets a flash success message" do
        expect(flash[:success]).not_to be_empty
      end
    end
    
    context "with invalid input" do
      before do
        dan = Fabricate(:admin)
        session[:user_id] = dan.id
        cat1 = Fabricate(:tag_category)
        post :create, params: { recipe: { name: ""}, new_tags: "new"}
      end
      
      it "doesn't create an ingredient" do
        expect(Recipe.count).to eq(0)
      end
      
      it "sets a flash error message" do
        expect(flash[:error]).not_to be_empty
      end
      
      it "renders the new recipe form" do
        expect(response).to render_template :new
      end
      
      it "doesn't create a new tag_category" do
        expect(TagCategory.count).to eq(1)
      end
    end
    
    context "with no tags attached" do
      before do
        dan = Fabricate(:admin)
        session[:user_id] = dan.id
        cat1 = Fabricate(:tag_category)
        chicken = Fabricate(:ingredient)
        post :create, params: { 
          recipe: { name: recipe_params[:name]}, new_tags: "  ",
          ing_id: ["#{chicken.id}"], unit: ["lb"], quantity: ["1"]
        }
      end
      
      it "creates an recipe" do
        expect(Recipe.count).to eq(1)
      end
      
      it "doesn't create new tag categories" do
        expect(TagCategory.count).to eq(1)
      end
      
      it "doesn't create any tag associations for recipe" do
        expect(Recipe.last.tags.size).to eq(0)
        expect(Recipe.last.tag_categories.size).to eq(0)
      end
    end
  end
end