require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using google oauth2" do
    visit root_path
    expect(page).to have_link("Sign in through Google")
    click_link "Sign in through Google"
    
    expect(page).to have_link("Approve Articles")
    click_link "Approve posts"
    expect(page).to have_content("Posts waiting for your approval")
    expect(page).to have_current_path(admin_articles_path)
    expect(page).to have_link("Logout")
    
    click_link("Logout")
    expect(page).to have_link("Sign in through Google")
    visit root_path
    expect(page).not_to have_content("Enter Page")
    visit admin_articles_path
    expect(page).to have_content("Sign in through Google")
  end
end

def stub_omniauth
  # set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true
  # then, provide a set of fake oauth data that
  # omniauth will use when a user tries to authenticate:
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
	  provider: 'google',
  	  uid: '12345',
  	  info: {
     		email: "bnguyen@colgate.edu", 
     		name: "Bao Nguyen"
  	}, 	  
  })
end
