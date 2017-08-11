require 'rails_helper'

describe Recipe do
  it { should validate_presence_of(:name) }
  it { should belong_to(:user) }
  it { should have_many(:recipe_ingredients).dependent(:destroy) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:ingredients) }
  it { should have_many(:tags) }
  it { should have_many(:tag_categories) }
  it { should have_many(:meal_plan_recipes) }
  it { should have_many(:meal_plans) }
  
  describe "#attach_tags" do
    let(:dan) { Fabricate(:admin) }
    let(:recipe) { Fabricate(:recipe, user: dan) }
    let(:tag) { Fabricate(:tag_category) }
    
    context "with a single existing tag" do
      before do
        params = { recipe: {tag_categories: [tag.id] }, new_tags: ""}
        recipe.attach_tags(params, dan.id)
      end
      
      it "creates a Tag" do
        expect(Tag.count).to eq(1)
      end
      
      it "creates a tag associated with the object" do
        expect(recipe.tag_categories).to eq([tag])
      end
    end
    
    context "with multiple tags" do
      before do
        params = { recipe: {tag_categories: [tag.id] }, new_tags: "Spicy, savory"}
        recipe.attach_tags(params, dan.id)
      end
      
      it "creates the correct number of Tags" do
        expect(Tag.count).to eq(3)
      end
      
      it "creates new TagCategories" do
        expect(TagCategory.count).to eq(3)
      end
      
      it "downcases tag categories" do
        expect(TagCategory.find_by(name: 'spicy')).to be_a(TagCategory)
      end
      
      it "strips tag categories of whitespace" do
        expect(TagCategory.find_by(name: 'savory')).to be_a(TagCategory)
      end
      
      it "associates the tags with the recipe" do
        expect(recipe.tags.count).to eq(3)
      end
    end
  end
  
  describe "#attach_ingredients" do
    context "with a single ingredient" do
      let(:recipe) { Fabricate(:recipe, user: dan) }
      let(:dan) { Fabricate(:admin) }
      let(:chicken) { Fabricate(:ingredient) }
      
      before do
        params = { unit: ["lb"], quantity: ["1"], ing_id: ["#{chicken.id}"] }
        recipe.attach_ingredients(params)
      end
      
      it "creates a RecipeIngredient" do
        expect(RecipeIngredient.count).to eq(1)
      end
      
      it "creates an association between the recipe and the ingredient" do
        expect(recipe.ingredients).to eq([chicken])
      end
    end
    
    context "with multiple ingredients" do
      let(:recipe) { Fabricate(:recipe, user: dan) }
      let(:dan) { Fabricate(:admin) }
      let(:chicken) { Fabricate(:ingredient, name: "chicken") }
      let(:pepper) { Fabricate(:ingredient, name: "pepper") }
      let(:rice) { Fabricate(:ingredient, name: "rice") }
      
      before do
        params = { unit: ["lb", "medium", "c"], quantity: ["1", "2", "1.5"], 
                   ing_id: ["#{chicken.id}", "#{pepper.id}", "#{rice.id}"] }
        recipe.attach_ingredients(params)
      end
      
      it "creates the right number of RecipeIngredients" do
        expect(RecipeIngredient.count).to eq(3)
      end
      
      it "creates an association between the recipe and the ingredient" do
        expect(recipe.ingredients).to eq([chicken, pepper, rice])
      end
      
      it "correctly matches the RecipeIngredient name with its unit and quantity" do
        expect(RecipeIngredient.find_by(ingredient_id: chicken.id).unit).to eq("lb")
        expect(RecipeIngredient.find_by(ingredient_id: chicken.id).quantity).to eq(1.0)
        expect(RecipeIngredient.find_by(ingredient_id: pepper.id).unit).to eq("medium")
        expect(RecipeIngredient.find_by(ingredient_id: pepper.id).quantity).to eq(2.0)
        expect(RecipeIngredient.find_by(ingredient_id: rice.id).unit).to eq("c")
        expect(RecipeIngredient.find_by(ingredient_id: rice.id).quantity).to eq(1.5)
      end
    end
  end
end