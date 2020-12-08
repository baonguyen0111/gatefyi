class FeedbacksController < ApplicationController
	before_action :is_logged_in?
	def index
		user = User.find(current_user.id)
		@feedbacks = user.feedbacks
		@feedback = Feedback.new
	end

	def create
		@feedback = Feedback.new(create_params)
		@feedback.user_id = current_user.id
		if @feedback.save
			flash[:notice] = "Waiting for admin to resolve"
			redirect_to feedbacks_path and return
		else
			flash[:alert] = "Failed to save feedback"
			redirect_to feedbacks_path and return
		end
	end

	private
	def create_params
		params.require(:feedback).permit(:content)
	end 

	def is_logged_in?
		unless (user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 
		end
	end
end
