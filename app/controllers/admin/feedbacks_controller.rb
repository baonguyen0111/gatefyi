class Admin::FeedbacksController < ApplicationController
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
		unless admin_signed_in?
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

end

