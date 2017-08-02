require 'rails_helper'

feature "Creating account" do
  given(:user_attributes) { Fabricate.attributes_for(:user) }
  given(:email) { user_attributes[:email] }
  given(:password) { user_attributes[:password] }
  given(:zip) { user_attributes[:zip_code] }
  
  background do
    visit register_path
    fill_in "Email Address", with: email
    fill_in "Password", with: password
  end
  
  scenario "User signs up with valid information" do
    fill_in "Zip Code", with: zip
    click_button "Sign Up"
    expect(page).to have_content("My Account")
    expect(page).to have_content("Welcome")
  end
  
  scenario "User signs up with invalid information" do
    fill_in "Zip Code", with: "1234"
    click_button "Sign Up"
    expect(page).to have_content("Invalid entry")
    expect(page).to have_content("should be in the form 12345 or 12345-1234")
  end
end

feature "Selecting Plan", js: true, driver: :poltergeist do
  given(:user_attributes) { Fabricate.attributes_for(:user) }
  given(:email) { user_attributes[:email] }
  given(:password) { user_attributes[:password] }
  given(:zip) { user_attributes[:zip_code] }
  
  background do
    visit register_path
    fill_in "Email Address", with: email
    fill_in "Password", with: password
    fill_in "Zip Code", with: zip
    choose "user_plan_silver_monthly"
    click_button "Sign Up"
  end
  
  scenario "User enters valid credit card info" do
    VCR.use_cassette("valid_stripe_subscription") do
      within_frame(find("iframe[title='Secure payment input frame']")) do
        fill_in 'cardnumber', with: "4242 4242 4242 4242"
        fill_in 'exp-date', with: "10 / 21"
        fill_in 'cvc', with: "123"
      end
      click_button "Start Your Subscription"
      sleep 3
      expect(page).to have_content "Subscription Started!"
    end
  end
  
  scenario "User enters invalid credit card info" do
    VCR.use_cassette("invalid_stripe_subscription") do
      within_frame(find("iframe[title='Secure payment input frame']")) do
        fill_in 'cardnumber', with: "4000 0000 0000 0002"
        fill_in 'exp-date', with: "10 / 21"
        fill_in 'cvc', with: "123"
      end
      click_button "Start Your Subscription"
      sleep 3
      expect(page).to have_content "Your card was declined."
      expect(page).to have_content "Checkout"
    end
  end
end

feature "Signing in" do
  background do
    @dan = Fabricate(:user)
  end
  
  scenario "Signing in with correct credentials" do
    sign_in(@dan)
    expect(page).to have_content "My Account"
  end
  
  scenario "Signing in with invalid password" do
    dan = Fabricate(:user)
    visit login_path
    fill_in 'Email Address', with: dan.email
    fill_in 'Password', with: dan.password + '123'
    click_button 'Sign in'
    expect(page).to have_content "Invalid Password."
    expect(find_field('Email Address').value).to eq dan.email
  end
end