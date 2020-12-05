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
			@arr = [@active_user, @articles, nil]
		#if filtered
		elsif params[:filter]
			#byebug
			if params[:popup]
				@select = []
				filter = params[:filter]
				if filter == "location"
					@select_states = Article.state_filter
					@select_city = Article.city_filter
					@select = [@select_states, @select_city]
				elsif filter == "company"
					@select_company = Article.company_filter
					@select = @select_company;
					#puts @select_company
				else
					@select_industry = Article.industry_filter
					@select = @select_industry
				end
				if session[:prev] == nil
					@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
					@arr = [@active_user, @articles, @select]
					respond_to do |format|
    					format.html
    					format.json {render 'popup.js.erb'} if request.xhr?
    				end
				#if a param was previous selcted, we should kepp follwing it when going to a different page
				else
					@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[session[:prev]].to_s + session[session[:prev]])
					@arr = [@active_user, @articles, @select]
					respond_to do |format|
    					format.html
    					format.json {render 'popup.js.erb'} if request.xhr?
    				end
				end
			else
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
				filter = params[:filter]
				#filter type
				@arr = [@active_user, @articles, nil]
				if filter == "location"
					#city and state
					city = params[city]
					state = params[state]
					if (city != "undefined") && (state != "undefined")
						if session[:prev] == nil
							@articles = @articles.where('state = ?', state).where('city = ?', city)
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('state = ?', state).where('city = ?', city).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					elsif city != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('city = ?', city)
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('city = ?', city).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					elsif state != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('state = ?', state)
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('state = ?', state).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					else
						if session[:prev] == nil
							@articles = @articles
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					end
				end
				if filter == "salary"
					#low and high
					low = params["low_salary"]
					high = params["high_salary"]
					if (low != "undefined") && (high != "undefined")
						if session[:prev] == nil
							@articles = @articles.where('compensation >= ?', low).where('compensation <= ?', high)
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('compensation >= ?', low).where('compensation <= ?', high).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					elsif low != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('compensation >= ?', low)
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('compensation >= ?', low).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					elsif high != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', high)
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', high).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					else
						if session[:prev] == nil
							@articles = @articles
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					end
				end
				if filter == "company"
					company = params["company"]
					if company != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('company = ?', company)
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('company = ?', company).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					else
						if session[:prev] == nil
							@articles = @articles
							@arr = [@active_user, @articles, nil]
					#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					end
				end
				if filter == "industry_type"
					industry = params["industry"]
					if industry != "undefined"
						if session[:prev] == nil
							@articles = @articles.where('industry_type = ?', industry)
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.where('industry_type = ?', industry).reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					else
						if session[:prev] == nil
							@articles = @articles
							@arr = [@active_user, @articles, nil]
						#if a param was previous selcted, we should kepp follwing it when going to a different page
						else
							@articles = @articles.reorder(queries[session[:prev]].to_s + session[session[:prev]])
							@arr = [@active_user, @articles, nil]
						end
					end
				end
				respond_to do |format|
    				format.html
    				format.json if request.xhr?
    			end
    		end
		else
			#if no sorting nor filtering param is selected (in the case of going to next or prev page)
			
			#if no param has ever been slected (the page was loaded for the first time)
			if session[:prev] == nil
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
				@arr = [@active_user, @articles, nil]	
			#if a param was previous selcted, we should kepp follwing it when going to a different page
			else
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[session[:prev]].to_s + session[session[:prev]])
				@arr = [@active_user, @articles, nil]
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
