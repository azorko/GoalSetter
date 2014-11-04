require "rails_helper"

feature "Comment" do
  let(:user1) { FactoryGirl.build(:user) }
  
  before :each do    
    visit new_user_url
    fill_in "Username", with: user1.username
    fill_in "Password", with: user1.password  
    click_button "Sign Up"
      
    visit user_url(user1)  
  end

  it "can comment a goal" do
    click_link "Comment"
    fill_in "body_goal", with: "Great goal! Keep it Up!"
    click_button "comment_goal" #id of the button
    click_link "Expand Comments"
    expect(page).to have_content("Great goal! Keep it Up!")
  end
  
  it "can comments on users" do
    fill_in "body_user", with: "You have great goals!"
    click_button "comment_user"
    expect(page).to have_content("You have great goals!")
  end
end