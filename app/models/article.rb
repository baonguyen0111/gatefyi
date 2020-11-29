class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy 
	validates :company, :industry_type, :state, :city, :interview_exp, :work_exp, presence: {message: "please fill in this field" }
	validates :compensation, numericality: {only_integer: true, message: "%{value} isn't integer"}
	def self.getApprovedArticles
		Article.where(admin_approved: true).order("approved DESC")	
	end

	def self.getUnapprovedArticles
		Article.where(admin_approved: false).order("approved DESC")	
	end

end
