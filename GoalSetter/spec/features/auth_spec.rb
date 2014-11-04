require 'rails_helper'

feature "the signup process" do 
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content("Sign Up")
  end

  
  feature "signing up a user" do
    
    it "shows username on the homepage after signup" do
      fill_in "Username", with: "test_user"
      fill_in "Password", with: "funky_password"
      click_button "Sign Up"
      expect(page).to have_content("test_user")
    end

  end
end

feature "user is signed in" do
  before :each do
    visit new_user_url
    fill_in "Username", with: "test_user"
    fill_in "Password", with: "funky_password"
    click_button "Sign Up"
    click_button "Sign Out"
    
    visit new_session_url
    fill_in "Username", with: "test_user"
    fill_in "Password", with: "funky_password"
    click_button "Sign In"
  end

  feature "logging in" do 
  
    it "shows username on the homepage after login" do
      expect(page).to have_content("test_user")
    end

  end

  feature "logging out" do 
    before :each do
      click_button "Sign Out"
    end
    it "begins with logged out state" do
      expect(page).to have_content("Sign In")
    end

    it "doesn't show username on the homepage after logout" do
      expect(page).not_to have_content("test_user")
    end
  end
  
end