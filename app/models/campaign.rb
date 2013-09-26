class Campaign < ActiveRecord::Base
	belongs_to :user # owner id

	# many to many with requests
	has_many :requests
	has_many :users, through: :requests

	# many to many with requests
	has_many :campaign_categorizations
	has_many :categories, through: :campaign_categorizations

	has_many :feedback

	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 150 }

	def to_param
		"#{id}/#{title}".parameterize
	end
end
