class Feedback < ActiveRecord::Base
	belongs_to :user
	belongs_to :campaign

	has_many :comments

	validates :body, presence: true
end
