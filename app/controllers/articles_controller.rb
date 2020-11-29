class ArticlesController < ApplicationController
	before_action :is_logged_in?
	def index
		most_active_poster = Article.most_active()
		most_active_commenter = Comment.most_active()
		hash = Hash.new(0)
		most_active_poster.each do |key, value|
			hash[key.to_i] = (value.to_i + most_active_commenter[key.to_i].to_i)
		end
		most_active_id = hash.max_by{|k,v| v}[0]
		@active_user = User.find(most_active_id)
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
		@arr = [@active_user, @articles]
		else
			#if no sorting param is selected (in the case of going to next or prev page)
			
			#if no param has ever been slected (the page was loaded for the first time)
			if session[:prev] == nil
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
				@arr = [@active_user, @articles]	
			#if a param was previous selcted, we should kepp follwing it when going to a different page
			else
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[session[:prev]].to_s + session[session[:prev]])
				@arr = [@active_user, @articles]
			end
		end
	end

	def show
		id = params[:id]
		article = Article.find(id)
		user_id = article.user_id
		article_owner = User.find(user_id)
		@arr = [article, article_owner]
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
		@industry_types = ArticlesHelper::INDUSTRY_TYPES
	end

	def create
		@article = Article.new(create_params)
		#byebug
		@article.upvotes = 0
		@article.user_id = current_user.id
		if @article.save
			flash[:notice] = "Waiting for approval from admin"
			redirect_to articles_path and return
		else
			flash[:alert] = "Failed to save new work experience"
			redirect_to new_article_path and return
		end
	end
	
	private

	def is_logged_in?
		unless (admin_signed_in? || user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 

		end
	end
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
