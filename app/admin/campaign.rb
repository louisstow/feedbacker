ActiveAdmin.register Campaign do
	index do
		column :title
		default_actions
	end

	filter :id

	form do |f|
		f.inputs "Admin Details" do
			f.input :title
			f.input :body
			f.input :user
			f.input :tag_list
		end
		f.actions
	end
end
