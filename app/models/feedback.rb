class Feedback < ActiveRecord::Base
	belongs_to :user
	belongs_to :campaign
end
