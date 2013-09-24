class Feedback < ActiveRecord::Base
	belongs_to :user
	belongs_to :campaign

	has_many :comments, dependent: :delete_all

	validates :body, presence: true

	default_scope order('rating desc')
end
