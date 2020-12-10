class CommentsController < ApplicationController
	before_action :is_logged_in?
	def index
		@article_id = params[:article_id]
		article = Article.find(@article_id)
		@hash = Hash.new(0)
		@comments = article.comments
		@comments.each do |c|
			comment_owner = User.find(c.user_id)
			@hash[c] = comment_owner
		end
	end

	def update
		id = params[:id]
		@comment = Comment.find(id)
		if params[:vote_change] 
			article_id = params[:article_id]
			change_upvotes
			redirect_to article_comments_path(article_id) and return 
		else
			edit_comment
		end
	end
	
	def edit
		@comment = Comment.find(params[:id])
		@article_id = params[:article_id]
	end

	def new
		@comment = Comment.new
		@article_id = params[:article_id]
	end

	def create
		@comment = Comment.new(create_params)
		@comment.upvotes = 0
		@comment.downvotes = 0
		@comment.user_id = current_user.id
		@comment.article_id = params[:article_id] 
		if @comment.save
			flash[:notice] = "Comment added"
			redirect_to article_comments_path(params[:article_id]) and return
		else
			flash[:alert] = "Failed to save comment"
			redirect_to new_article_comment_path(params[:article_id]) and return
		end

	end
	private
	def create_params
		params.require(:comment).permit(:content)
	end

	def is_logged_in?
		unless (user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 

		end
	end

	def change_upvotes
		vote_change = params.require(:vote_change).to_i
	        if (vote_change == 1)
			@comment.upvotes += vote_change
		else 	
			@comment.downvotes -= vote_change
		end
		
		if @comment.save
			flash[:notice] = "#{vote_change == 1 ? 'Upvoted' : 'Downvoted'} successfully"
		else
			flash[:alert] = "Failed to upvote"	
		end
	end
	
	def edit_comment
		@comment.attributes = params.require(:comment).permit(:content)
		if @comment.save
			flash[:notice] = "Comment edited"
			redirect_to article_comments_path(params[:article_id]) and return
		else
			flash[:alert] = "Failed to save comment"
			redirect_to new_article_comment_path(params[:article_id]) and return
		end
	end
end
