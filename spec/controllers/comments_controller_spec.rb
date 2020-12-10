require "rails_helper"

RSpec.describe CommentsController, type: :controller do 
	

	context "index" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)	
			get :index
            expect(response.status).to eq(200)
		end

		it "renders the index template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			c = Comment.create!(content: "cool beans", upvotes: 1, downvotes: 0, user_id: a.id, article_id: p.id)
    		get :index, :params => { :article_id => p.id }
    		expect(assigns(:comment)).to match_array([c])
    		expect(response).to render_template("index")
		end
	
	end
	
	context "show" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			c = Comment.create!(content: "cool beans", upvotes: 1, downvotes: 0, user_id: a.id, article_id: p.id)
    		expect(Comment).to receive(:find).with(eq("1").or eq(1)) { c }
    		get :show, :params => { :id => 1 }
    		expect(response.status).to eq(200)
		end

		it "renders the show template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			c = Comment.create!(content: "cool beans", upvotes: 1, downvotes: 0, user_id: a.id, article_id: p.id)
			expect(Comment).to receive(:find).with(eq("1").or eq(1)) { c }
			expect(User).to receive(:find).with(eq("1").or eq(1)) {a}
			get :show, :params => { :id => 1 }
			expect(assigns(:comment)).to eq(c)
			expect(response).to render_template("show")
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
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 10, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: true, user_id: a.id)
			allow(controller).to receive(:current_user).and_return(a)
			get :create, :params => {:comment => {content: "cool beans", upvotes: 1, downvotes: 0, user_id: a.id, article_id: p.id}}
    		expect(response).to have_http_status(:redirect)
		end
	end
	
	
end
