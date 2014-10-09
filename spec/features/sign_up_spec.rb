require 'rails_helper'

describe "Signing up a new User" do 
  before { 
    @exercise = Exercise.create(name: "Single Stroke Roll")
    visit '/signup' 
  }
  
  context "with valid information" do
    before do 
      within('.new_user') do 
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
      end 
      click_button "Sign Up"
    end
    
    it "should let the user know it was created" do 
      expect(page).to have_content("New user created!")
    end
    
    it "should be logged in as the user" do 
      expect(page).to have_content("Logged in as Example User")
    end
  end
end
