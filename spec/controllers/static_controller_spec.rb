require "rails_helper"

RSpec.describe StaticController, type: :controller do
	context "root route" do
		it "routes to static#index" do
			expect(:get => '/').to route_to(:controller => 'static', :action => 'index')
		end
	end

	context "about route" do 
		it "routes correctly" do
			get :aboutus 
			expect(response.status).to eq(200)
		end
	end

	context "howto route" do
		it "routes correctly" do
			get :howto
			expect(response.status).to eq(200)
		end
	end


end
