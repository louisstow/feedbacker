class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def list
		@campaigns = Campaign.find_by_category(params[:name])
	end
end
