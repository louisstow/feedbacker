class Request < ActiveRecord::Base
	belongs_to :campaign
	belongs_to :user

	self.primary_key = [:user_id, :campaign_id]
end
