class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	# replace with your authenticate method
	def google_oauth2
		auth = request.env["omniauth.auth"]
		byebug
		admin = Admin.where(provider: auth["provider"], uid: auth["uid"])
			.first_or_initialize(email: auth["info"]["email"])
		admin.name ||= auth["info"]["name"]
		admin.save!

		admin.remember_me = true
		sign_in(:admin, admin)

		redirect_to after_sign_in_path_for(admin)
	end

	protected

	def after_omniauth_failure_path_for(_scope)
		root_path
	end

	def after_sign_in_path_for(resource_or_scope)
		 stored_location_for(resource_or_scope) || root_path
	end
end
