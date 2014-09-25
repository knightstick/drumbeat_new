require 'rails_helper'

describe "Pages"  do
  context "home page" do
    before { visit '/' }
    it "should welcome user" do
      expect(page).to have_content 'Welcome'
    end
    
    it "should have sign up button" do
      expect(page).to have_css('.btn', text: 'Sign up now!')
    end
    
    it "should have login link" do
      expect(page).to have_link("Log in")
    end
  end
  
  context "Sign up page" do
    before { visit '/signup' }
    
    it "should have title 'Sign Up'" do 
      expect(page).to have_content 'Sign Up'
    end
  end
  
  context "Log in page" do 
    before { visit '/login' }
    
    it "should have title 'Log In'" do 
      expect(page).to have_content 'Log In'
    end
  end
end