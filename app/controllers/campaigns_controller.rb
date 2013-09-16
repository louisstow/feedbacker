class CampaignsController < ApplicationController
	before_action :require_login, only: [:create, :new]

	def show
		@campaign = Campaign.find(params[:id])
	end

	def new
		@campaign = Campaign.new
	end

	def create
		vals = params[:campaign].permit(:title, :body, :tag_list)
		@campaign = Campaign.new(vals)
		@campaign.user_id = session[:user_id]

		if @campaign.save
			redirect_to root_path
		else
			render 'new'
		end
	end
end
