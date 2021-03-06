require "rails_helper"

RSpec.describe ArticlesController, type: :controller do 


	context "index" do
		it "not logged in" do
			get :index
			expect(response).to have_http_status(:redirect)
		end
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)	
			get :index
			expect(response.status).to eq(200)
		end

		it "renders the index template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			get :index
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by company" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'company', :company => 'Amazon'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "filters by company" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'company', :company => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by industry" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'industry_type', :industry => 'Tech'}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by industry" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'industry_type', :industry => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by location" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'location', :state => 'CA', :city => 'Seattle'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "filters by location" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'location', :state => '', :city => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by location" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'location', :state => 'CA', :city => ''}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end

		it "filters by location" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'location', :state => '', :city => 'Seattle'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "filters by salary" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'salary', :low_salary => '10000', :high_salary => '70000'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "filters by salary" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'salary', :low_salary => '', :high_salary => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by salary" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'salary', :low_salary => '90000', :high_salary => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by salary" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:filter => 'salary', :low_salary => '', :high_salary => '50000'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (company) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'company', :filter_company => 'Amazon'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (industry) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'industry_type', :filter_industry => 'Tech'}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (location) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'location', :filter_city => nil, :filter_state => 'WA'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (location) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'location', :filter_city => 'San Jose', :filter_state => nil}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'salary', :filter_low => nil, :filter_high => '90000'}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'salary', :filter_low => '10000', :filter_high => '50000'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'salary', :filter_low => '90000', :filter_high => nil}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after sorting" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:query => 'salary'}, :session => {:filter_by => 'salary', :filter_low => nil, :filter_high => '90000'}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end
		
		it "filters by company before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :company => 'Amazon'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end
		
		it "filters by company before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :company => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end
		
		it "filters by industry before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :industry_type => 'Tech'}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by industry before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :industry_type => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by location before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :state => 'CA', :city => 'Seattle'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "filters by location before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :state => '', :city => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by location before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :state => 'CA', :city => ''}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end

		it "filters by location before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :state => '', :city => 'Seattle'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "filters by salary before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :compensationlow => '10000', :compensationhigh => '70000'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end

		it "filters by salary before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :compensationlow => '', :compensationhigh => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by salary before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)

			get :index, :params => {:commit => 'Apply filter', :compensationlow => '90000', :compensationhigh => ''}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end

		it "filters by salary before real filter" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:commit => 'Apply filter', :compensationlow => '', :compensationhigh => '50000'}
			expect(assigns(:articles)).to match_array([])
			expect(response).to render_template("index")
		end
		
		it "preserves filtered articles (company) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '2'}, :session => {:filter_by => 'company', :filter_company => 'Amazon'}
			expect(assigns(:articles)).to match_array([y])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (industry) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			
			get :index, :params => {:page => '9'}, :session => {:filter_by => 'industry_type', :filter_industry => 'Tech'}
			expect(assigns(:articles)).to match_array([x,y,z,m])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (location) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '1'}, :session => {:filter_by => 'location', :filter_city => nil, :filter_state => 'WA'}
			expect(assigns(:articles)).to match_array([y,n])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (location) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '1'}, :session => {:filter_by => 'location', :filter_city => 'San Jose', :filter_state => nil}
			expect(assigns(:articles)).to match_array([x])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '2'}, :session => {:filter_by => 'salary', :filter_low => nil, :filter_high => '90000'}
			expect(assigns(:articles)).to match_array([x,z,m,n])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '1'}, :session => {:filter_by => 'salary', :filter_low => '10000', :filter_high => '50000'}
			expect(assigns(:articles)).to match_array([z,m])
			expect(response).to render_template("index")
		end

		it "preserves filtered articles (salary) after changing page" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y, z, m, n = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: true, user_id: a.id), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Facebook", industry_type: "Tech", state: "NY", city: "New York", compensation: 50000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Tencent", industry_type: "Tech", state: "MA", city: "Boston", compensation: 40000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id),
				Article.create!(company: "Business Inc", industry_type: "Acounting", state: "WA", city: "Seattle", compensation: 70000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
				
			get :index, :params => {:page => '2'}, :session => {:filter_by => 'salary', :filter_low => '90000', :filter_high => nil}
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("index")
		end
	end

	context "show" do
		it "record not found" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved:true, user_id: a.id)
			get :show, :params => { :id => 10 }
			expect(response).to have_http_status(:redirect)

		end
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved:true, user_id: a.id)
			get :show, :params => { :id => p.id }
			expect(response.status).to eq(200)
		end

		it "renders the show template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)

			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			get :show, :params => { :id => p.id}
			expect(assigns(:article)).to eq(p)
			expect(response).to render_template("show")
		end

		it "upvote/downvote correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			get :show, :params => { :id => 1 }
			get :update, :params => { :id => 1, :vote_change => 1 } 
			expect(response).to have_http_status(:redirect)
			expect(Article.find(1).upvotes).to eq(11)  
			get :update, :params => { :id => 1, :vote_change => -1 } 
			get :update, :params => { :id => 1, :vote_change => -1 } 
			get :update, :params => { :id => 1, :vote_change => -1 } 
			expect(response).to have_http_status(:redirect)
			expect(Article.find(1).upvotes).to eq(8)
		end

	end

	context "new" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			get :new
			expect(response.status).to eq(200)
		end

		it "renders the new template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			get :new
			expect(response).to have_http_status(:success)
			expect(response).to render_template(:new)
		end
	end

	context "create" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			allow(controller).to receive(:current_user).and_return(a)
			get :create, :params => {:article => {company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00)}}
			expect(response).to have_http_status(:redirect)
		end
	end


end
