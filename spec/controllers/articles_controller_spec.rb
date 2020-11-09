require "rails_helper"

RSpec.describe ArticlesController, type: :controller do 
	context "root route" do
		it "routes to articles#index" do
			expect(:get => '/').to route_to(:controller => 'articles', :action => 'index')
		end
	end

	context "index" do
		it "routes correctly" do 
			get :index
            expect(response.status).to eq(200)
		end

		it "renders the index template" do
			x, y = Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00)), Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
            get :index
            expect(assigns(@articles)['articles'].to_a).to match_array([x,y])
            expect(response).to render_template("index")
		end
	end

	context "show" do
		it "routes correctly" do
			p = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
            expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response.status).to eq(200)
		end

		it "renders the show template" do
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
            expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response).to render_template("show")
            expect(assigns(:article)).to eq(p)
		end
		
		it "upvote/downvote correctly" do
			Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
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
			get :new
    		expect(response.status).to eq(200)
		end
		
		it "renders the new template" do
            get :new
            expect(response).to have_http_status(:success)
        	expect(response).to render_template(:new)
        end
	end
	
	context "create" do
		it "routes correctly" do
			get :create, :params => {:article => {company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00)}}
    		expect(response).to have_http_status(:redirect)
		end
	end
end
