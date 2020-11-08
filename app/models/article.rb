class Article < ApplicationRecord
	validates :company, :industry_type, :state, :city, :interview_exp, :word_exp, presence:true
	validates :compensation, numericality: {only_integer: true}
end
