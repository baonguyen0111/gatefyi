require "rails_helper"

RSpec.describe ChatsController, type: :controller do
	context "index" do
		it "not logged in" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)	
			get :index
			expect(response).to have_http_status(:redirect)

		end
		it "routes correctly" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)	
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)	
			#expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
			get :index
			expect(response.status).to eq(200)
		end

		it "renders the index template" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)	

			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			get :index
			expect(response).to render_template("index")
		end	
	end

	context "create" do
		it "renders route correctly" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			b1 = User.create!(name: "Jacob Potter", email: "jpotter@colgate.edu", provider: "google", uid: "100000000000000000002", displayname: "jpotter", description: "Colgate freshman", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "Hey wu", user_id: a.id, chat_id: c.id)	

			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			get :create, :params => {:sender_id => a.id, :recipient_id => b1.id} 
			expect(response).to have_http_status(:redirect)
		end 

		it "create new chat when not present" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			b1 = User.create!(name: "Jacob Potter", email: "jpotter@colgate.edu", provider: "google", uid: "100000000000000000002", displayname: "jpotter", description: "Colgate freshman", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "Hey wu", user_id: a.id, chat_id: c.id)	

			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			expect {
				get :create, :params => {:sender_id => a.id, :recipient_id => b1.id}
			}.to change { Chat.count }
			expect(response).to have_http_status(:redirect)
		end

		it "get current chat " do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			b1 = User.create!(name: "Jacob Potter", email: "jpotter@colgate.edu", provider: "google", uid: "100000000000000000002", displayname: "jpotter", description: "Colgate freshman", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "Hey wu", user_id: a.id, chat_id: c.id)	

			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			get :create, :params => {:sender_id => a.id, :recipient_id => b.id}
			expect(assigns(:chat)).to match(c)
			expect(response).to have_http_status(:redirect)
		end
	end	
end
