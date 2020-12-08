class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :feedbacks, dependent: :destroy
	has_many :chats, :foreign_key => :sender_id
	has_one_attached :avatar

	devise :rememberable, :omniauthable, omniauth_providers: [:google_oauth2]
	 
	def self.from_omniauth(auth, isAdmin)
		User.where(provider: auth['provider'], uid: auth['uid']).first_or_create do |user|
			user.provider = auth['provider']
			user.uid = auth['uid']
			user.email = auth['info']['email']
			user.name ||= auth['info']['name']
			user.displayname ||= auth['info']['name']
			user.isAdmin = isAdmin
		end
	end
end
