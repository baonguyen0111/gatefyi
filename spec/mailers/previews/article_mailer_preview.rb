#Preview all emails at http://localhost:3030/rails/mailers/article_mailer
class ArticleMailerPreview < ActionMailer::Preview
	def new_article_email	
				
		user = User.new(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true)
		article = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, admin_approved: true,  approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: user.id) 
		ArticleMailer.with(article: article, user: user).new_article_email
	end
end
