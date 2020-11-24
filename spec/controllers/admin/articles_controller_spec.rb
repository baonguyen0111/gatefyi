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
			x, y = 
				Article.create!(company: "Uber", industry_type: "Tech", state: "CA", city: "San Jose", compensation: 90000, interview_exp: "Hard interview. System design questions", work_exp: "get work in different teams, pretty cool perks", upvotes: 0, approved: DateTime.new(2020, 11, 04, 04, 00, 00), admin_approved: false), 
				Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00), admin_approved: false)


			get :index
			expect(assigns(:articles)).to match_array([x,y])
			expect(response).to render_template("admin/articles/index")
		end


	end

	context "show" do
		it "routes correctly" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			p = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
			expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			get :show, :params => { :id => 1 }
			expect(response.status).to eq(200)
		end

		it "renders the show template" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)
			p = Article.create!(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
			expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			get :show, :params => { :id => 1 }
			expect(response).to render_template("show")
			expect(assigns(:article)).to eq(p)
		end

	end

=begin
	context "update" do
		it "routes correctly" do
			allow(controller).to receive(:admin_logged_in?).and_return(true)

			p = Article.create!(company: "hello", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))
		# byebug
		expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }


			get :destroy, :params => { :id => 1}
			# byebug
			# expect(response.status).to eq(200)




		end
		# it "approve correctly" do
		# 	allow(controller).to receive(:admin_logged_in?).and_return(true)
		# 	p = Article.create!(company: "hell", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, approved: DateTime.new(2020, 11, 04, 03, 00, 00))

  #          get :update, :params => { :id => 1,:approval => true }
  #          expect(Article).to receive(:admin_approve).with(1, true)


		# end
	end
=end
end
