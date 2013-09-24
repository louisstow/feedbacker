ActiveAdmin.register User do
	index do
		column :full_name
		column :email
		default_actions
	end

	filter :email
	filter :id
end
