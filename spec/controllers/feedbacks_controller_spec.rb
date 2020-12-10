require "rails_helper"

RSpec.describe FeedbacksController, type: :controller do
	context "index" do
		it "not logged in" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			get :index
			expect(response).to have_http_status(:redirect)
		end
		it "routes correctly" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)	
			get :index
    			expect(response.status).to eq(200)
		end

		it "renders the index template" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			x, y = 
				Feedback.create!(content: "Why is this lagging so bad!??", resolved: false, user_id: a.id),
				Feedback.create!(content: "Please just shut this site down", resolved: false, user_id: a.id)
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			get :index
    			expect(assigns(:feedbacks)).to match([x,y])
    			expect(response).to render_template("index")
		end	
	end

	context "create" do
		it "renders route correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			allow(controller).to receive(:current_user).and_return(a)
			get :create, :params => {:feedback => {:content => "Huh..why so few posts?"}}
			expect(response).to have_http_status(:redirect)
		end 
	end	
end
