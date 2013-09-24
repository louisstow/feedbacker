ActiveAdmin.register Category do
	index do
		column :name
		default_actions
	end

	filter :id
end
