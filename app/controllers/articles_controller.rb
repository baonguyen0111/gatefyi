class ArticlesController < ApplicationController
	#linh and bao
	def index
		@articles = Article.order("approved DESC").paginate(:page => params[:page], :per_page => 4)
	end

	def show
		id = params[:id]
		@article = Article.find(id)
	end

	def update
		id = params[:id]
		@article = Article.find(id)
		@article.upvotes += 1
		if @article.save
			flash[:notice] = "Upvoted successfully"
			redirect_to article_path(@article)
		else
			flash[:alert] = "Failed to upvote"	
			redirect_to article_path(@article)
		end
	end	

	#mingche and fanyi
	def new
	end

	def create
	end
end
