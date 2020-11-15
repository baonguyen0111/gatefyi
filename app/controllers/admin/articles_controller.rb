class Admin::ArticlesController < ApplicationController
	before_action :admin_logged_in?

	def index
		@articles = Article.getUnapprovedArticles.paginate(:page => params[:page], :per_page => 4)
	end

	def show
		id = params[:id]
		@article = Article.find(id)

	end

	private
	def admin_logged_in?
		unless admin_signed_in?
			flash[:alert] =  "Only admin users can access this page"
			redirect_to articles_path and return 

		end

	end
	
	def admin_approve
		approval = params.require(:approval)
		if approval
			@article.admin_approved = true 
			flash[:notice] = "post approved!"
		else
			flash[:alert] = "post rejected."
		end 
	end 
end
