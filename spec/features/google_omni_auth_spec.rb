require 'rails_helper'

RSpec.feature "log in with google oauth 2.0" do
    before :each do
        OmniAuth.config.test_mode = true
    end

    scenario "as a user" do
        OmniAuth.config.mock_auth[:google_oauth2] = {
            'uid' => '1337',
            'provider' => 'google_oauth2',
            'info' => {
                'name' => 'Test User', 
                'email' => 'test@colgate.edu'
            }
        } 
        visit root_path
        expect(page).to have_link("Sign in through Google")
        click_link "Sign in through Google"
        
        expect(page).to have_link("Add Post")
        click_link "Add Post"
        expect(page).to have_current_path(new_article_path)
        expect(page).to have_content("Create new work experience")
        click_link "Back to main page"
        
        expect(page).to have_link("Submit Feedbacks")
        click_link "Submit Feedbacks"
        expect(page).to have_current_path(feedbacks_path)
        expect(page).to have_content("All your past feedbacks")
        click_link "Back to main page"
        
        expect(page).not_to have_content("Approve Articles")
        expect(page).not_to have_content("Check Feedbacks")
        
        expect(page).to have_link("Log Out")
        click_link("Log Out")
        visit root_path
        expect(page).not_to have_content("Enter our page")
        visit admin_articles_path
        expect(page).to have_content("Sign in through Google")
    end
  
    scenario "as an admin" do
        OmniAuth.config.mock_auth[:google_oauth2] = {
            'uid' => '1337',
            'provider' => 'google_oauth2',
            'info' => {
                'name' => 'Admin User', 
                'email' => 'bnguyen@colgate.edu'
            }
        } 
        visit root_path
        expect(page).to have_link("Sign in through Google")
        click_link "Sign in through Google"
        
        expect(page).to have_link("Approve Articles")
        click_link "Approve Articles"
        expect(page).to have_current_path(admin_articles_path)
        expect(page).to have_content("Posts waiting for your approval")
        click_link "Back to main page"
        
        expect(page).to have_link("Check Feedbacks")
        click_link "Check Feedbacks"
        expect(page).to have_current_path(admin_feedbacks_path)
        expect(page).to have_content("Feedbacks waiting for you to resolve")
        
        expect(page).to have_link("Log Out")
        click_link("Log Out")
        visit root_path
        expect(page).not_to have_content("Enter our page")
        visit admin_articles_path
        expect(page).to have_content("Sign in through Google")
    end
    
    scenario "as a non-user" do
        OmniAuth.config.mock_auth[:google_oauth2] = {
            'uid' => '1337',
            'provider' => 'google_oauth2',
            'info' => {
                'name' => 'Non User', 
                'email' => 'non_user_test@gmail.com'
            }
        }
        
        visit root_path
        expect(page).to have_link("Sign in through Google")
        click_link "Sign in through Google"
        
        expect(page).not_to have_content("Approve Articles")
        expect(page).not_to have_content("Add Post")
        expect(page).not_to have_content("Check Feedbacks")
        expect(page).not_to have_content("Submit Feedbacks")
        
        expect(page).to have_content("Sign in through Google")
        expect(page).to have_current_path(root_path)
    end
end


