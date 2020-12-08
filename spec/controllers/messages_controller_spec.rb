require "rails_helper"

RSpec.describe MessagesController, type: :controller do
	context "#index" do
		it "routes correctly" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)	
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)	
			#expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
			get :index, :params => {:chat_id => c.id} 
			expect(response.status).to eq(200)

		end
		it "renders index template" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m1 = Message.new	
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			marr = [m, m1]	
			#expect(User).to receive(:find).with(eq("1").or eq(1)) { a }
			get :index, :params => {:chat_id => c.id}
			expect(assigns(:messages)[0]).to match(marr[0])
			expect(response).to render_template("index")
			expect(response.status).to eq(200)
		end
		it "checks when no. of messages > 8" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m1 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m2 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m3 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m4 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m5 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m6 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m7 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m8 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			m9 = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)
			marr = [m1, m2, m3, m4, m5, m6, m7, m8, m9]
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)
			get :index, :params => {:chat_id => c.id, :viewall => true}
			newarr = assigns(:messages).to_a
			newarr.pop() 	
			expect(newarr).to match(marr)
			expect(response).to render_template("index")
		end
	end

	context "#create" do
		it "routes correctly" do
			a = User.create!(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true, isAdmin: false)
			b = User.create!(name: "Jeehuyn Park", email: "jpark@colgate.edu", provider: "google", uid: "100000000000000000001", displayname: "jpark", description: "Colgate sophomore", show_profile: true)
			c = Chat.create!(sender_id: a.id, recipient_id: b.id)
			m = Message.create!(message: "hey wu", user_id: a.id, chat_id: c.id)	
			allow(controller).to receive(:is_logged_in?).and_return(true)
			allow(controller).to receive(:current_user).and_return(a)	
			get :create, :params => {:message => {:message => "how r u", :user_id => a.id}, :chat_id => c.id}
			expect(response).to have_http_status(:redirect)

		end
	end
end
