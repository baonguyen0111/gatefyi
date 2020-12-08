require "rails_helper"

RSpec.describe "show page", type: :feature do
	before :each do
		User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
		Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: 1)
		Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: 1)
		visit root_path
		expect(page).to have_link("Sign in through Google")
		click_link "Sign in through Google"

		visit "/articles"
	end

	it "should have links from each company name to 'show' pages" do
		expect(page).to have_link("Amazon")
		expect(page).to have_link("Uber")
	end

	it "show link for company name should show details for the company's review" do
		click_link("Amazon")
		expect(page).to have_link("Back to main page")
		expect(page).to have_content("Amazon")
		expect(page).to have_content("Tech")
		expect(page).to have_content("Seattle, WA")
		expect(page).to have_content("Pretty simple interview")
		expect(page).to have_content("Great team. Challenging work")
		expect(page).to have_content("$100,000.00")
		expect(find_by_id('upvoteCount')).to have_content("10")
	end

	it "show link for company name should show details for the company's review" do
		click_link("Uber")
		expect(page).to have_link("Back to main page")
		expect(page).to have_content("Uber")
		expect(page).to have_content("Tech")
		expect(page).to have_content("San Jose, CA")
		expect(page).to have_content("Hard interview. System design questions")
		expect(page).to have_content("get work in different teams, pretty cool perks")
		expect(page).to have_content("$90,000.00")
		expect(find_by_id('upvoteCount')).to have_content("0")
	end
end
