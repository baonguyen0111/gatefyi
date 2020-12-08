require "rails_helper"

RSpec.describe UsersController, type: :controller do 
	context "show" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
    		expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
    		get :show, :params => { :id => 1 }
    		expect(response).to have_http_status(:success)
		end 

		it "render correct template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
    		expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
    		get :show, :params => { :id => 1 }
    		expect(response).to have_http_status(:success)
    		expect(response).to render_template(:show)
		end 
		
        it "should correctly handle bad id's with the show route" do 
            User.create!
            get :show, :params => { :id => 1000 }
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to(root_path)
        end
	end

	context "edit" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
    		expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
			get :edit, :params => { :id => 1 }
    		expect(response).to have_http_status(:success)
		end
		
		it "render correct template" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
    		expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
			get :edit, :params => { :id => 1 }
    		expect(response).to have_http_status(:success)
    		expect(response).to render_template(:edit)
		end
	end
	
	context "update" do
		it "routes correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			allow(controller).to receive(:current_user).and_return(a)
			
			get :update, :params => {:id => 1, :user => {displayname: "TRAN LINH", show_profile: "false"}}
    		expect(response).to have_http_status(:redirect)
    		expect(response).to redirect_to :action => :show, :id => 1   
		end
		
		it "update details correctly" do
			allow(controller).to receive(:is_logged_in?).and_return(true)
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			allow(controller).to receive(:current_user).and_return(a)
			
			get :update, :params => {:id => 1, :user => {displayname: "TRAN LINH", show_profile: "false"}}
			a = User.find(a.id)
    		expect(response).to have_http_status(:redirect)
    		expect(a.displayname).to eq("TRAN LINH")
    		expect(a.name).to eq("Linh Tran")
    		expect(a.show_profile).to eq(false)
    		expect(a.description).to eq("Colgate senior. Into research")
    		
    	    get :update, :params => {:id => 1, :user => {displayname: "Linh Tran", show_profile: "true", image: "http://google.com", description: "Colgate grad"}}
			a = User.find(a.id)
    		expect(response).to have_http_status(:redirect)
    		expect(a.displayname).to eq("Linh Tran")
    		expect(a.description).to eq("Colgate grad")
    		expect(a.show_profile).to eq(true)
    		expect(a.image).to eq("http://google.com")
		end
	end
end
