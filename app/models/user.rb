class User < ActiveRecord::Base
	# many to many with requests
	has_many :requests
	has_many :campaigns, through: :requests

	# many to many with categories
	has_many :user_categorizations
	has_many :categories, through: :user_categorizations

	has_many :campaigns
	has_many :feedbacks
	has_many :notifications

	validates :full_name, presence: true, length: { minimum: 2 }
	validates :bio, presence: true, length: { maximum: 500 }
	validates :email, presence: true, uniqueness: true
	validates :category_ids, length: {maximum: 3, message: " must be 3 or less"}

	has_secure_password validations: false
	validates :password, presence: true, length: { minimum: 5 }, on: :create

	validates :access_code, inclusion: { in: ['crackerbacker'], message: " is invalid" }

	attr_accessor :access_code
	
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

	def giveKarma (amount)
		increment(:score, amount)
	end

	def giveKarma! (amount)
		giveKarma amount
		save(validate: false)
	end

end
