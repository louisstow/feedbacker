class Comment < ActiveRecord::Base
	belongs_to :feedback
	belongs_to :user

	validates :body, presence: true
end
