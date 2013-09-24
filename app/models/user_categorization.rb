class UserCategorization < ActiveRecord::Base
	belongs_to :user
	belongs_to :category

	self.primary_keys = :category_id, :user_id
end
