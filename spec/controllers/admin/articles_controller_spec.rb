require "rails_helper"

RSpec.describe Admin::ArticlesController, type: :controller do 

	context "index" do

		it "routes correctly" do 
			allow(controller).to receive(:admin_logged_in?).and_return(true)	
			get :index
			expect(response.status).to eq(200)
		end
		it "renders the index template" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			u= User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: true)	
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: false, user_id: u.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: false, user_id: u.id)
			get :index
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("admin/articles/index")
		end


	end

	context "show" do
		it "routes correctly" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			u= User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: true)	
			p = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: u.id)
			expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			get :show, :params => { :id => 1 }
			expect(response.status).to eq(200)
		end

		it "renders the show template" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			u= User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: true)	
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: u.id)
			expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			get :show, :params => { :id => 1 }
			expect(response).to render_template("show")
			expect(assigns(:article)).to eq(p)
		end
		
		it "approve" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			u= User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: true)	

			Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: u.id)
			get :update, :params => { :id => 1, :approval => true } 
            		expect(response).to have_http_status(:redirect)
            		expect(Article.find(1).admin_approved).to be_truthy
		end
		
		it "reject" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			u= User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: true)	
			Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: u.id)
			
			get :destroy, :params => { :id => 1, :approval => false } 
            expect{Article.find(1)}.to raise_error(ActiveRecord::RecordNotFound)
            expect(response).to have_http_status(:redirect)
		end

	end
end
