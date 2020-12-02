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

	def self.most_active
		Article.joins(:user).group(:user_id).count(:user_id)
	end
	
	def self.company_filter
		Article.distinct.pluck(:company)
	end 
	
	def self.industry_filter
		Article.distinct.pluck(:industry_type)
	end 
	
	def self.state_filter
		Article.distinct.pluck(:state)
	end 
	
	def self.city_filter
		Article.distinct.pluck(:city)
	end 
end
