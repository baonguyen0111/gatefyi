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
		
		if params[:vote_change] 
			change_upvotes
		end
		
		redirect_to article_path(@article) and return 
	end	

	#mingche and fanyi
	def new
		@article = Article.new
		@us_states = ArticlesHelper::US_STATES
	end

	def create
		@article = Article.new(create_params)
		#byebug
		@article.upvotes = 0
		#byebug
		if @article.save
			flash[:notice] = "New work experience created"
			redirect_to articles_path and return
		else
			flash[:alert] = "Failed to save new  work experience"
			redirect_to new_article_path and return
		end
	end
	
	private
	
	def create_params
		params.require(:article).permit(:company, :industry_type, :state, :city, :compensation, :interview_exp, :work_exp)
	end 
	
	def change_upvotes
		vote_change = params.require(:vote_change).to_i 
		@article.upvotes += vote_change
		
		if @article.save
			flash[:notice] = "#{vote_change == 1 ? 'Upvoted' : 'Downvoted'} successfully"
		else
			flash[:alert] = "Failed to upvote"	
		end
	end
end
