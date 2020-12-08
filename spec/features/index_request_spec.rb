require "rails_helper"

RSpec.describe "index page", type: :feature do
	let(:salary_ASC_sort_pg1) { ["$100,000.00", "$200,000.00", "$300,000.00", "$400,000.00"] }
	let(:salary_DSC_sort_pg1) { ["$500,000.00", "$400,000.00", "$300,000.00", "$200,000.00"] }
	let(:salary_ASC_sort_pg2) { ["$500,000.00"] }
	let(:company_ASC_sort_pg1) { ["$100,000.00", "$300,000.00", "$400,000.00", "$500,000.00"] }
	let(:location_ASC_sort_pg1) { ["$500,000.00", "$400,000.00", "$300,000.00", "$200,000.00"] }
	let(:industry_ASC_sort_pg1) { ["$200,000.00", "$500,000.00", "$400,000.00", "$300,000.00"] }
	let(:upvotes_ASC_sort_pg1) { ["$100,000.00", "$200,000.00", "$300,000.00", "$500,000.00"] }

	before :each do
		User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
		Article.create!(:company => "Amazon", :industry_type => "Tech", :state => "WA", :city => "Seattle", :compensation => 100000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 0, admin_approved: true, :approved => DateTime.new(2020, 11, 04, 00, 00, 00), user_id: 1)
		Article.create!(:company => "Uber", :industry_type => "Car", :state => "NY", :city => "New York", :compensation => 200000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 1, admin_approved: true, :approved => DateTime.new(2021, 11, 04, 00, 00, 00), user_id: 1)
		Article.create!(:company => "Facebook", :industry_type => "SpyWare", :state => "NJ", :city => "Trenton", :compensation => 300000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 2, admin_approved: true, :approved => DateTime.new(2022, 11, 04, 00, 00, 00), user_id: 1)
		Article.create!(:company => "Netflix", :industry_type => "Movies", :state => "ID", :city => "Cityland", :compensation => 500000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 3, admin_approved: true, :approved => DateTime.new(2024, 11, 04, 00, 00, 00), user_id: 1)
		Article.create!(:company => "Google", :industry_type => "Search", :state => "MB", :city => "PlaceBerg", :compensation => 400000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 4, admin_approved: true, :approved => DateTime.new(2025, 11, 04, 00, 00, 00), user_id: 1)
		visit root_path
		expect(page).to have_link("Sign in through Google")
		click_link "Sign in through Google"

		visit "/articles"
	end

	it "should show the articles in correct salary order when sorting by ASC salary" do
		names = []
		click_link("Salary")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(salary_ASC_sort_pg1)
	end

	it "should show the articles in correct salary order when sorting by DSC salary" do
		names = []
		click_link("Salary")
		click_link("Salary")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(salary_DSC_sort_pg1)
	end

	it "should show the articles in correct salary order when sorting by ASC salary after previously sorting by DSC" do
		names = []
		click_link("Salary")
		click_link("Salary")
		click_link("Salary")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(salary_ASC_sort_pg1)
	end

	it "should show the articles in correct salary order when sorting by ASC salary after going to the next page" do
		names = []
		click_link("Salary")
		visit "/articles?page=2"
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(salary_ASC_sort_pg2)
	end

	it "should show the articles in correct company name order when sorting by ASC company" do
		names = []
		click_link("Company")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(company_ASC_sort_pg1)
	end

	it "should show the articles in correct location order when sorting by ASC company" do
		names = []
		click_link("Location")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(location_ASC_sort_pg1)
	end

	it "should show the articles in correct industy order when sorting by ASC company" do
		names = []
		click_link("Industry")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(industry_ASC_sort_pg1)
	end

	it "should show the articles in correct upvotes order when sorting by ASC company" do
		names = []
		click_link("Upvotes")
		page.all(".articlecompensation").each { |x| names << x.text }
		expect(names).to match_array(upvotes_ASC_sort_pg1)
	end

end
