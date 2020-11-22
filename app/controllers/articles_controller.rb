class ArticlesController < ApplicationController
	#linh and bao
	def index
		#tyler
		queries = {"company" => :company, "industy" => :industry_type, "location" => :state, "salary" => :compensation, "upvotes" => :upvotes}
		#if a sorting param has been selected
    	if queries.key? params[:query]
	    	#decide if we should sort by ASC or DESC
	    	if session[:prev] == params[:query]
	    		if session[params[:query]] == ' DESC'
	    			session[params[:query]] = ' ASC'
	    		else
	    			session[params[:query]] = ' DESC'
	    		end
	    	else
	    		session[params[:query]] = ' ASC'
	    	end
	        #Sort and update where needed
	        @articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[params[:query]].to_s + session[params[:query]])
	        session[:prev] = params[:query]
	        params[:query] = nil
		else
			#if no sorting param is selected (in the case of going to next or prev page)
			
			#if no param has ever been slected (the page was loaded for the first time)
			if session[:prev] == nil
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
			
			#if a param was previous selcted, we should kepp follwing it when going to a different page
			else
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[session[:prev]].to_s + session[session[:prev]])
			end
		end
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
			flash[:notice] = "Waiting for approval from admin"
			redirect_to articles_path and return
		else
			flash[:alert] = "Failed to save new work experience"
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
