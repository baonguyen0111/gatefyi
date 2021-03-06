class ArticlesController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
	before_action :is_logged_in?

	def index
		@no_of_posts = Article.count
		@no_of_comments = Comment.count
		@no_of_messages = Message.count
		most_active_poster = Article.most_active()
		most_active_commenter = Comment.most_active()
		hash = Hash.new(0)
		most_active_poster.each do |key, value|
			hash[key.to_i] = (value.to_i + most_active_commenter[key.to_i].to_i)
		end
		if hash.empty? 
			@most_active_user = ""
		else
			most_active_id = hash.max_by{|k,v| v}[0]
			@most_active_user = User.find(most_active_id)
		end
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
			@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[params[:query]].to_s + session[params[:query]])
			#preserve previous filter before sorting
			if session[:filter_by]
				filter = session[:filter_by]
				if filter == "company"
					value = session[:filter_company]
					@articles = @articles.where('company = ?', value)
				elsif filter == "industry_type"
					value = session[:filter_industry]
					@articles = @articles.where('industry_type = ?', value)
				elsif filter == "location"
					value1 = session[:filter_state]
					value2 = session[:filter_city]
					if value1
						@articles = @articles.where('state = ?', value1)
					end
					if value2
						@articles = @articles.where('city = ?', value2)
					end
				else
					value1 = session[:filter_low]
					value2 = session[:filter_high]
					if value1 && value2
						@articles = @articles.where('compensation >= ?', value1).where('compensation <= ?', value2)
					elsif value1
						@articles = @articles.where('compensation >= ?', value1)
					elsif value2
						@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', value2)
					end
				end
			end
			#Sort and update where needed
			session[:prev] = params[:query]
			params[:query] = nil
			#if filtered
		elsif params[:commit] == "Apply filter"
			@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
			if params[:company]
				company = params[:company]
				@articles = @articles.where('company = ?', company) unless company == ""
			elsif params[:industry_type]
				industry = params[:industry_type]
				@articles = @articles.where('industry_type = ?', industry) unless industry == ""
			elsif params[:city]
				city = params[:city]
				state = params[:state]
				if city != "" && state != ""
					@articles = @articles.where('state = ?', state).where('city = ?', city)
				elsif city != ""
					@articles = @articles.where('city = ?', city)
				elsif state != ""
					@articles = @articles.where('state = ?', state)
				end
			elsif params[:compensationlow]
				low = params[:compensationlow]
				high = params[:compensationhigh]
				if low != "" && high != ""
					@articles = @articles.where('compensation >= ?', low).where('compensation <= ?', high)
				elsif low != ""
					@articles = @articles.where('compensation >= ?', low)
				elsif high != ""
					@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', high)
				end
			end
		elsif params[:filter]
			filter = params[:filter]
			session[:filter_by] = filter
			#filter type
			@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
			if filter == "location"
				#city and state
				city = params["city"]
				state = params["state"]
				if city != "" && state != ""
					session[:filter_city] = city
					session[:filter_state] = state
					@articles = @articles.where('state = ?', state).where('city = ?', city)
				elsif city != ""
					session[:filter_city] = city
					session[:filter_state] = nil
					@articles = @articles.where('city = ?', city)
				elsif state != ""
					session[:filter_state] = state
					session[:filter_city] = nil
					@articles = @articles.where('state = ?', state)
				else
					session[:filter_by] = nil
				end
			end
			if filter == "salary"
				#low and high
				low = params["low_salary"]
				high = params["high_salary"]
				if low != "" && high != ""
					session[:filter_low] = low
					session[:filter_high] = high
					@articles = @articles.where('compensation >= ?', low).where('compensation <= ?', high)
				elsif low != ""
					session[:filter_low] = low
					session[:filter_high] = nil
					@articles = @articles.where('compensation >= ?', low)
				elsif high != ""
					session[:filter_low] = nil
					session[:filter_high] = high
					@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', high)
				else
					session[:filter_by] = nil
				end
			end
			if filter == "company"
				company = params["company"]
				if company != ""
					session[:filter_company] = company
					@articles = @articles.where('company = ?', company)
				else
					session[:filter_by] = nil
				end
			end
			if filter == "industry_type"
				industry = params["industry"]
				if industry != ""
					session[:filter_industry] = industry
					@articles = @articles.where('industry_type = ?', industry)
				else
					session[:filter_by] = nil
				end
			end
			if request.xhr?
				render(partial: 'articles', locals:{articles: @articles}) and return
			end
		elsif params[:page]
			@articles = Article.getApprovedArticles
			if session[:filter_by]
				filter = session[:filter_by]
				if filter == "company"
					value = session[:filter_company]
					@articles = @articles.where('company = ?', value)
				elsif filter == "industry_type"
					value = session[:filter_industry]
					@articles = @articles.where('industry_type = ?', value)
				elsif filter == "location"
					value1 = session[:filter_state]
					value2 = session[:filter_city]
					if value1
						@articles = @articles.where('state = ?', value1)
					end
					if value2
						@articles = @articles.where('city = ?', value2)
					end
				else
					value1 = session[:filter_low]
					value2 = session[:filter_high]
					if value1 && value2
						@articles = @articles.where('compensation >= ?', value1).where('compensation <= ?', value2)
					elsif value1
						@articles = @articles.where('compensation >= ?', value1)
					elsif value2
						@articles = @articles.where('compensation >= ?', 0).where('compensation <= ?', value2)
					end
				end
			end
			page = params[:page].to_i
			length = @articles.length
			which = page
			if page * 4 > length
				which = page - (page * 4 - length) / 4
				which = 1 if which == 0
			end
			@articles = @articles.paginate(:page => which.to_s, :per_page => 4)
			@articles = @articles.reorder(queries[session[:prev]].to_s + session[session[:prev]]) unless session[:prev] == nil
		else
			#if no sorting nor filtering param is selected (in the case of going to next or prev page)

			#if no param has ever been slected (the page was loaded for the first time)
			if session[:prev] == nil
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4)
				#if a param was previous selcted, we should kepp follwing it when going to a different page
			else
				@articles = Article.getApprovedArticles.paginate(:page => params[:page], :per_page => 4).reorder(queries[session[:prev]].to_s + session[session[:prev]])
			end
			session[:filter_by] = nil
		end
	end

	def show
		id = params[:id]
		@article = Article.find(id)
		user_id = @article.user_id
		@owner = User.find(user_id)
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
		@article.upvotes = 0
		@article.user_id = current_user.id
		if @article.save
			#ArticleMailer.with(article: @article, user: current_user).new_article_email.deliver_now
			flash[:notice] = "Waiting for approval from admin"
			redirect_to articles_path and return
		else
			flash[:alert] = "Failed to save new work experience"
			redirect_to new_article_path and return
		end
	end

	private

	def is_logged_in?
		unless (user_signed_in?)
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

	def record_not_found
		flash[:alert] = "Articles not found"	
		redirect_to articles_path and return 
	end
end
