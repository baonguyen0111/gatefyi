class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy
	devise :rememberable, :registerable
	def self.from_omniauth(auth)
		User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.info.email
			user.name ||= auth["info"]["name"]
		end
	end
end
