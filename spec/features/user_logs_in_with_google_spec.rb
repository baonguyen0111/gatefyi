require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using google oauth2" do
    visit root_path
    expect(page).to have_link("Sign in through Google")
    click_link "Sign in through Google"
    
    expect(page).to have_link("Approve posts")
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


