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
		@article = Article.new
	end

	def create
		redirect_to articles_path
		
	end
	
	private
	  def create_params
	  	params.require(:article) .permit(:company, :industry_type, :state, :city, :compensation, :interview_exp, :work_exp, :upvote)
	  end 
end
