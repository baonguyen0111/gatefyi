class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# replace with your authenticate method
	def google_oauth2
		auth = request.env["omniauth.auth"]
		admin_accpt = [ENV["ADMIN_EMAIL_1"], ENV["ADMIN_EMAIL_2"], ENV["ADMIN_EMAIL_3"]]
		isAdmin = false
		if auth["info"]["email"].split("@")[1] != "colgate.edu"
		
			redirect_to root_path
			flash[:alert] = "Sorry, app is exclusive for Colgate students" 
		else
			
			if admin_accpt.include?(auth["info"]["email"])
				isAdmin = true 
			else
				isAdmin = false
			end
			@user = User.from_omniauth(auth, isAdmin)
			@user.save!
			@user.remember_me = true
			sign_in(:user, @user)
			flash[:notice] = "Welcome to our app"
			redirect_to after_sign_in_path_for(@user)
		end
		

	end

	protected

	def after_omniauth_failure_path_for(_scope)
		root_path
	end

	def after_sign_in_path_for(resource_or_scope)
		 stored_location_for(resource_or_scope) || articles_path
	end
end
