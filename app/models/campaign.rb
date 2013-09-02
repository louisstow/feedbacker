class Campaign < ActiveRecord::Base
	belongs_to :user # owner id

	has_many :requests
	has_many :users, through: :requests

	has_many :feedbacks
end
