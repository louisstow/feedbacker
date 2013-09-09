class UserCategorization < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	self.primary_key = [:user_id, :category_id]
end
