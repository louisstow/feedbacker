class User < ActiveRecord::Base
	has_many :requests
	has_many :campaigns, through: :requests

	has_many :campaigns
	has_many :feedbacks

	attr_accessor :category

	validates :name, presence: true
end
