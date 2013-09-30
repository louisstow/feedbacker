class NotificationsController < ApplicationController
	def clear
		if current_user_id
			Notification.delete_all({user_id: current_user_id})
		end
	end
end
