require 'rails_helper'

feature "Goal" do
  let(:user1) { FactoryGirl.build(:user) }
  
  before :each do    
    visit new_user_url
    fill_in "Username", with: user1.username
    fill_in "Password", with: user1.password  
    click_button "Sign Up"
      
    visit user_url(user1)  
  end
  
  feature "Create goal" do
    before :each do
      click_link "New Goal"
      fill_in "Title", with: "Run a marathon"
      click_button "Create Goal"
    end  
    
    it "creates a goal and shows on users profile" do
      expect(page).to have_content("Run a marathon")
    end
  end
  
  feature "Show goal" do
    it "has indicator to show if goal has been completed" do
      expect(page).not_to have_content("x")
    end
  end
  
  feature "Update goal" do
    before :each do
      click_link "New Goal"
      fill_in "Title", with: "Gain weight"
      click_button "Create Goal"
      
      click_link "Edit"
      fill_in "Title", with: "Lose 10 pounds"
      select "Private", from: "Set Public"
      select "Completed", from: "Completed"
      click_button "Update"
    end
    it "will let user change the goal" do
      expect(page).to have_content("Lose 10 pounds")
      expect(page).to have_content("x")
    end
  end
  
  feature "Delete goal" do
    before :each do
      click_link "New Goal"
      fill_in "Title", with: "Gain weight"
      click_button "Create Goal"
      click_button "Remove"
    end
    it "will remove goal from user's show page" do
      expect(page).not_to have_content("It's a title!")
    end
  end
end