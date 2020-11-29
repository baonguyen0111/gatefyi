class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :article

	def self.most_active
		Comment.joins(:user).group(:user_id).count(:user_id)
	end
end
