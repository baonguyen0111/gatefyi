require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using google oauth2" do
    stub_omniauth
    
    visit root_path
    expect(page).to have_link("Log in as admin")
    click_link "Log in as admin"
    
    expect(page).to have_link("Approve posts")
    click_link "Approve posts"
    expect(page).to have_content("Posts waiting for your approval")
    expect(page).to have_current_path(admin_articles_path)
    expect(page).to have_link("Logout")
    
    click_link("Logout")
    expect(page).to have_link("Log in as admin")
    visit root_path
    expect(page).not_to have_content("Approve posts")
    vist admin_articles_path
    expect(response).to have_http_status(:redirect)
  end
end

def stub_omniauth
  # set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true
  # then, provide a set of fake oauth data that
  # omniauth will use when a user tries to authenticate:
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    ## must intialize fake stub for testing 
  })
end
