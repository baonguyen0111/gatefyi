class Message < ApplicationRecord
	belongs_to :chat
	belongs_to :user
	validates_presence_of :message, :chat_id, :user_id

	def message_time
		created_at.strftime("%m/%d/%y at %l:%M %p")
	end
end
