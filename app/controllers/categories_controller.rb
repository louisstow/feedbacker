class CategoriesController < ApplicationController
	def index
		@categories = Category.all
	end

	def list
		@campaigns = Category
			.find_by_name!(params[:name])
			.campaigns
	end

	def top_users
		@users = Category
			.find_by_name(params[:name])
			.user_categorizations
			.joins(:user)
			.select("user_categorizations.*, users.id, users.full_name, users.score as karma")
			.order("user_categorizations.score desc")
	end
end
