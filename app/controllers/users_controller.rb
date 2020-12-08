class UsersController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
	before_action :is_logged_in?
	
	def show
		id = params[:id]
		@user = User.find(id)
	end
	
	def edit
		id = params[:id]
		@user = User.find(id)
	end

	def update
		id = params[:id]
		@user = User.find(id)
		if @user.update(edit_params)
			flash[:success] = "User profile updated"
		else
			flash[:alert] = "Fail to update"
		end 
		
		redirect_to user_path(id) and return 
	end

	private

	def is_logged_in?
		unless (user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 
		end
	end
	
	def record_not_found
		flash[:alert] = "Users not found"	
		redirect_to articles_path and return 
	end
	
	def edit_params
		params.require(:user).permit(:displayname, :description, :show_profile, :image)
	end 
end

