require "rails_helper"

RSpec.describe ArticlesController, type: :controller do 
	

	context "index" do
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
	end
	
	
		


	context "show" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved:true, user_id: a.id)
            		expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            		get :show, :params => { :id => 1 }
            		expect(response.status).to eq(200)
		end

		it "renders the show template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)

			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
            		expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			expect(User).to receive(:find).with(eq("1").or eq(1)) {a}
            		get :show, :params => { :id => 1 }
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
