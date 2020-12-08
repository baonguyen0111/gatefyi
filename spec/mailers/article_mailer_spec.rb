require "rails_helper"

RSpec.describe ArticleMailer, type: :mailer do
	describe "notify" do
		it "email admin" do
			user = User.new(name: "Linh Tran", email: "ltran@colgate.edu", provider: "google_oauth2", uid: "100000000000000000000", displayname: "ltran", description: "Colgate senior. Into research", show_profile: true)
			article = Article.new(company: "Amazon", industry_type: "Tech", state: "WA", city: "Seattle", compensation: 100000, interview_exp: "Pretty simple interview", work_exp: "Great team. Challenging work", upvotes: 0, admin_approved: true,  approved: DateTime.new(2020, 11, 04, 03, 00, 00), user_id: user.id)
			email = ArticleMailer.with(article: article, user: user).new_article_email
			assert_emails 1 do
				email.deliver_now
			end

			expect(email.to).to eq(["fmo@colgate.edu"])
			expect(email.from).to eq(["from@example.com"])
			expect(email.subject).to eq("You have a post waiting")
			expect(email.html_part.body.encoded).to match(user.displayname)
			expect(email.text_part.body.encoded).to match(user.displayname)
			expect(email.html_part.body.encoded).to match(article.company)
			expect(email.text_part.body.encoded).to match(article.work_exp)
			expect(email.html_part.body.encoded).to match(article.work_exp)

		end
	end
end
