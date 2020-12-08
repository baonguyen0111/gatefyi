require 'rails_helper'
RSpec.feature "test as admin" do
  scenario "using google oauth2" do
    visit root_path
    click_link "Sign in through Google"
    Article.create!(:company => "NoNet", :user_id => "1", :industry_type => "Movies", :state => "ID", :city => "Cityland", :compensation => 500000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 3, :approved => DateTime.new(2024, 11, 04, 00, 00, 00))
    Article.create!(:company => "Net", :user_id => "1", :industry_type => "Movies", :state => "ID", :city => "Cityland", :compensation => 500000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 3, :approved => DateTime.new(2024, 11, 04, 00, 00, 00))
  
    click_link "Approve posts"
    expect(page).to have_link("Net")
    click_link("Net")
    expect(page).to have_link("Approve")
    expect(page).to have_link("Reject")
    click_link("Approve")
    expect(page).to have_content("Post approved")
    click_link("NoNet")
    expect(page).to have_link("Approve")
    expect(page).to have_link("Reject")
    click_link("Reject")
    expect(page).to have_content("Post rejected")
  end
end


