class ArticleMailer < ApplicationMailer
	def new_article_email
		@article = params[:article]
		@user = params[:user]
		admin_emails = [ENV["ADMIN_EMAIL_1"], ENV["ADMIN_EMAIL_2"], ENV["ADMIN_EMAIL_3"]]
		admin_emails.each do |a|
			mail(to: a, subject: "You have a post waiting")
		end
	end
end
