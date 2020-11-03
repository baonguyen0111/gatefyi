require "rails_helper"

Rspec.describe ArticlesController, type: :controller do 
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
			p = Article.new(name: "Amazon")
            get :index
            #If we want to also check that it's indexed correctly by some standard, we would have to add it here.
            expect(response).to render_template("index")
		end
	end

	context "show" do
		it "routes correctly" do
			p = Article.new(name: "Amazon")
            expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response.status).to eq(200)
		end

		it "renders the show template" do
			p = Article.new(name: "Amazon")
            expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            get :show, :params => { :id => 1 }
            expect(response).to render_template("show")
            expect(assigns(:article)).to eq(p)
		end

	end
	
	context "new" do
		it "routes correctly" do
			get :new
    		expect(response.status).to eq(200)
		end
		
		it "renders the new template"
			p = Article.new(name: "Amazon")
            expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
            get :new, :params => { :id => 1 }
            expect(response).to have_http_status(:success)
        	expect(response).to render_template(:new)
        end
	end
	
	context "create" do
		it "routes correctly" do
			get :create
    		expect(response.status).to eq(200)
		end
		
		it "renders the create template" do
			#we need to add more things about the creation of an article to properly check
			p = Article.new(name: "Amazon")
			expect(Article).to receive(:find).with(eq("1").or eq(1)) { p }
			get :create, :params => { :id => 1 }
			expect(response).to have_http_status(:success)
        	expect(response).to render_template(:create)
		end
	end

