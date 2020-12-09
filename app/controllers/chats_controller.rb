class ChatsController < ApplicationController
	before_action :is_logged_in?
	def index
	
		@users = User.all
	
		@chats = Chat.all
	end
	def create
		
		if Chat.between(params[:sender_id],params[:recipient_id])
			.present?
			@chat = Chat.between(params[:sender_id],
				     params[:recipient_id]).first
		else
			@chat = Chat.create!(chat_params)
		end
		redirect_to chat_messages_path(@chat)
	end
	private
	def chat_params 
		params.permit(:sender_id, :recipient_id)
	end
	def is_logged_in?
		unless (user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 

		end
	end
end
