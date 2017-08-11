require 'rails_helper'

describe Admin::IngredientsController do
  describe "GET new" do
    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
    
    it_behaves_like "requires admin" do
      let(:action) { get :new }
    end
    
    it "sets @ingredient" do
      dan = Fabricate(:admin)
      session[:user_id] = dan.id
      get :new
      expect(assigns(:ingredient)).to be_a(Ingredient)
    end
  end
  
  describe "POST create" do
    let(:ingredient_params) { Fabricate.attributes_for(:ingredient) }
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create, params: { ingredient: { name: ingredient_params[:name]}}}
    end
    
    it_behaves_like "requires admin" do
      let(:action) { post :create, params: { ingredient: { name: ingredient_params[:name]}}}
    end
    
    context "with valid input" do
      before do
        dan = Fabricate(:admin)
        session[:user_id] = dan.id
        cat1 = Fabricate(:tag_category)
        cat2 = Fabricate(:tag_category)
        cat3 = Fabricate(:tag_category)
        post :create, params: { ingredient: { name: ingredient_params[:name], tag_categories: [cat1.id, cat2.id]}, new_tags: "New, tag"}
      end
      
      it "creates an ingredient" do
        expect(Ingredient.count).to eq(1)
      end
      
      it "redirects to the new admin ingredient path" do
        expect(response).to redirect_to new_admin_ingredient_path
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
        post :create, params: { ingredient: { name: ""}, new_tags: "new"}
      end
      
      it "doesn't create an ingredient" do
        expect(Ingredient.count).to eq(0)
      end
      
      it "sets a flash error message" do
        expect(flash[:error]).not_to be_empty
      end
      
      it "renders the new ingredient form" do
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
        post :create, params: { ingredient: { name: ingredient_params[:name]}, new_tags: "  "}
      end
      
      it "creates an ingredient" do
        expect(Ingredient.count).to eq(1)
      end
      
      it "doesn't create new tag categories" do
        expect(TagCategory.count).to eq(1)
      end
      
      it "doesn't create any tag associations for ingredient" do
        expect(Ingredient.last.tags.size).to eq(0)
        expect(Ingredient.last.tag_categories.size).to eq(0)
      end
    end
  end
end