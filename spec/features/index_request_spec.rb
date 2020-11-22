require "rails_helper"

RSpec.describe "index page", type: :feature do
    let(:salary_ASC_sort) { ["Amazon", "Uber", "Facebook" ] }
    let(:salary_DSC_sort) { [ "Facebook", "Uber", "Amazon" ] }

  before :each do
    Article.create!(:company => "Amazon", :industry_type => "Tech", :state => "WA", :city => "Seattle", :compensation => 100000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 0, :approved => DateTime.new(2020, 11, 04, 03, 00, 00))
    Article.create!(:company => "Uber", :industry_type => "Tech", :state => "NY", :city => "New York", :compensation => 200000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 0, :approved => DateTime.new(2020, 11, 04, 02, 00, 00))
    Article.create!(:company => "Facebook", :industry_type => "Tech", :state => "NJ", :city => "Trenton", :compensation => 300000, :interview_exp => "Pretty simple interview", :work_exp => "Great team. Challenging work", :upvotes => 0, :approved => DateTime.new(2020, 11, 04, 03, 00, 00))

    visit "/articles"
  end

  it "should show the articles in correct salary order when sorting by ascengin salary" do
    names = []
    click_link("Salary")
    page.all(".articlecompany").each { |x| names << x.text }
    expect(names).to match_array(salary_ASC_sort)
  end
end
