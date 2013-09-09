class CampaignCategorization < ActiveRecord::Base
	belongs_to :category
	belongs_to :campaign

	self.primary_key = [:campaign_id, :category_id]
end
