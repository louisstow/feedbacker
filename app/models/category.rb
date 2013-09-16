class Category < ActiveRecord::Base
	has_many :user_categorizations
	has_many :users, through: :user_categorizations

	has_many :campaign_categorizations
	has_many :campaigns, through: :campaign_categorizations
end
