class Admin < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]
	def self.from_omniauth(auth)
		Admin.where(provider: auth.provider, uid: auth.uid).first_or_create do |admin|
			admin.provider = auth.provider
			admin.uid = auth.uid
			admin.email = auth.info.email
			admin.name ||= auth["info"]["name"]
		end
	end


end
