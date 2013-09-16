class Campaign < ActiveRecord::Base
	belongs_to :user # owner id

	# many to many with requests
	has_many :requests
	has_many :users, through: :requests

	# many to many with requests
	has_many :campaign_categorizations
	has_many :categories, through: :campaign_categorizations

	has_many :feedback

	accepts_nested_attributes_for :feedback

	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 150 }
	validates :tag_list, presence: true

	def tag_list
		categories.map(&:name).join(", ")
	end

	def tag_list=(names)
		names = names.split(",")
		names.each do |c|
			cat = Category.where(name: c.strip).first

			if cat
				self.categories << cat
			end
		end
	end

	def to_param
		"#{id}/#{title}".parameterize
	end
end
