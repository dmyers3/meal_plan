require 'rails_helper'

feature "User resets password" do
  scenario "user resets password with valid email and password" do
    dan = Fabricate(:user, password: 'old_password')

    visit login_path
    click_link "Forgot your password?"
    fill_in 'Email Address', with: dan.email
    click_button 'Send Email'
    
    open_email(dan.email)
    current_email.click_link("Reset My Password")
    expect(page).to have_content("Reset Your Password")
    
    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    
    expect(page).to have_content("Logout")
  end
  
  scenario "user resets password with invalid email" do
    dan = Fabricate(:user, password: 'old_password')

    visit login_path
    click_link "Forgot your password?"
    fill_in 'Email Address', with: "wrong_email@example.com"
    click_button 'Send Email'
    
    expect(page).to have_content("Could not find email address.")
  end
  
  scenario "user resets password with valid email but invalid password" do
    dan = Fabricate(:user, password: 'old_password')

    visit login_path
    click_link "Forgot your password?"
    fill_in 'Email Address', with: dan.email
    click_button 'Send Email'
    
    open_email(dan.email)
    current_email.click_link("Reset My Password")
    expect(page).to have_content("Reset Your Password")
    
    fill_in "New Password", with: "short"
    click_button "Reset Password"
    
    expect(page).to have_content("Invalid password.")
    expect(page).to have_content("Reset Your Password")
  end
end