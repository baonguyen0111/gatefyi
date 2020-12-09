class MessagesController < ApplicationController

	before_action :is_logged_in?
	before_action do
		@chat = Chat.find(params[:chat_id] )
	end

	def index
		@messages = @chat.messages
		if @messages.length > 8
			@over_limit = true
			@messages = @messages[-8..-1]
		end

		if params[:viewall]
			@over_limit = false
			@messages = @chat.messages
		end

		if @messages.last
			if @messages.last.user_id != current_user.id
				@messages.last.read = true;
			end
		end

		@message = @chat.messages.new
	end

	#def new
	#	@message = @chat.messages.new
	#end

	def create
		@message = @chat.messages.new(message_params)
		if @message.save
			redirect_to chat_messages_path(@chat)
		end
	end
	private
	def is_logged_in?
		unless (user_signed_in?)
			flash[:alert] =  "Only authenticated users can access this page"
			redirect_to root_path and return 

		end
	end

	def message_params
		params.require(:message).permit(:message, :user_id)
	end
end	
