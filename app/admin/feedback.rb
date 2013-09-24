ActiveAdmin.register Feedback do
	index do
		column :body
		default_actions
	end

	filter :campaign_id
end
