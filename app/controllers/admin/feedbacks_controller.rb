class Admin::FeedbacksController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
	before_action :admin_logged_in?
	
	def index
		@feedbacks = Feedback.all
	end

	def update
		id = params[:id]
		@feedback = Feedback.find(id)
		if params[:resolved]
			approve
		end
		redirect_to admin_feedbacks_path and return
	end
	
	private
	
	def admin_logged_in?
		unless (user_signed_in? && current_user.isAdmin)
			flash[:alert] =  "Only admin users can access this page"
			redirect_to root_path and return 
		end
	end
	
	def approve
		resolved = params.require(:resolved)
		@feedback.resolved = resolved 
		if @feedback.save
			flash[:notice] = "Post approved"
		else
			flash[:alert] = "Failed to approve post"
		end
	end 
	
	def record_not_found
		flash[:alert] = "Feedbacks not found"	
		redirect_to admin_feedbacks_path and return 
	end
end

