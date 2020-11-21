class Admin::ArticlesController < ApplicationController
	before_action :admin_logged_in?

	def index
		@articles = Article.getUnapprovedArticles.paginate(:page => params[:page], :per_page => 4)
	end

	def show
		id = params[:id]
		@article = Article.find(id)
	end
	
	def update
		id = params[:id]
		@article = Article.find(id)
		if params[:approval]
			admin_approve
		end
		redirect_to admin_articles_path and return
	end
	
	def destroy
		id = params[:id]
		@article = Article.find(id)
		@article.destroy
		flash[:notice] = "post rejected"
		redirect_to admin_articles_path and return
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
		@article.admin_approved = approval
		if @article.save
			flash[:notice] = "post approved"
		else
			flash[:alert] = "Failed to approve post"
		end
	end 
end
