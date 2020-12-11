class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.newsletter_mailer.subject
  #
  default from: "gatefyi83@gmail.com"
  def newsletter_mailer
    @articles = Article.last(2)
    @user = User.where(isInNL: true)
    if  @user
      emails = @user.collect(&:email).join(", ")
      mail(to: emails, subject: "What you miss this week")
    end

  end
end
