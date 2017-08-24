require 'rails_helper'

feature "Admin adds ingredient" do
  scenario "admin clicks dropdown to visit create ingredient page" do
    dan = Fabricate(:admin)
    sign_in(dan)
    
    click_link "Ingredients"
    click_link "Create Ingredient"
    expect(page).to have_content "Add New Ingredient"
  end
  
  scenario "admin adds ingredient with valid input" do
    dan = Fabricate(:admin)
    sign_in(dan)
    
    visit new_admin_ingredient_path
    fill_in "Ingredient Name", with: "chicken"
    fill_in "New Tags (comma-separated)", with: "Meat, lean"
    click_button "Create Ingredient"
    
    expect(page).to have_content("Ingredient added!")
    expect(page).to have_content("Add New Ingredient")
  end
  
  scenario "admin adds ingredient with invalid input" do
    dan = Fabricate(:admin)
    sign_in(dan)
    
    visit new_admin_ingredient_path
    fill_in "New Tags (comma-separated)", with: "Meat, lean"
    click_button "Create Ingredient"
    
    expect(page).to have_content("Ingredient not added.")
    expect(page).to have_content("Add New Ingredient")
  end
  
  scenario "admin clicks dropdown to visit create recipe page" do
    dan = Fabricate(:admin)
    sign_in(dan)
    
    click_link "Recipes"
    click_link "Create Recipe"
    expect(page).to have_content "Add New Recipe"
  end
  
  scenario "admin adds recipe with valid input" do
    dan = Fabricate(:admin)
    chicken = Fabricate(:ingredient)
    rice = Fabricate(:ingredient)
    sign_in(dan)
    
    visit new_admin_recipe_path
    fill_in "Recipe Name", with: "Chicken and Rice"
    fill_in "Prep Time (in minutes)", with: 10
    fill_in "Cook Time (in minutes)", with: 15
    fill_in "Instructions", with: "Cook chicken well to internal temp of 165 degrees."
    fill_in "New Tags (comma-separated)", with: "Meat, lean"
    
    fill_in "Quantity", with: 1
    select "lb", from: "unit"
    select chicken.name, from: "ingredient_name"
    click_button "Create Recipe"
    
    expect(page).to have_content("Recipe added!")
    expect(page).to have_content("Add New Recipe")
  end
end