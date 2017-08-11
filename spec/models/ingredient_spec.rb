require 'rails_helper'

describe Ingredient do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:recipe_ingredients) }
  it { should have_many(:recipes) }
  it { should have_many(:tags).dependent(:destroy) }
  it { should have_many(:tag_categories) }
  
  describe "#attach_tags" do
    let(:dan) { Fabricate(:admin) }
    let(:ingredient) { Fabricate(:ingredient) }
    let(:tag) { Fabricate(:tag_category) }
    
    context "with a single existing tag" do
      before do
        params = { ingredient: {tag_categories: [tag.id] }, new_tags: ""}
        ingredient.attach_tags(params, dan.id)
      end
      
      it "creates a Tag" do
        expect(Tag.count).to eq(1)
      end
      
      it "creates a tag associated with the object" do
        expect(ingredient.tag_categories).to eq([tag])
      end
    end
    
    context "with multiple tags" do
      before do
        params = { ingredient: {tag_categories: [tag.id] }, new_tags: "Spicy, savory"}
        ingredient.attach_tags(params, dan.id)
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
      
      it "associates the tags with the ingredient" do
        expect(ingredient.tags.count).to eq(3)
      end
    end
  end
end