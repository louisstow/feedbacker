class CampaignsController < ApplicationController
	before_action :require_login, only: [:create, :new, :edit, :update, :destroy]

	def show
		@campaign = Campaign.find(params[:id])
		@feedbacks = Campaign.where(campaign_id: @campaign.id).order("score desc")
	end

	def new
		@campaign = Campaign.new
	end

	def create
		vals = params[:campaign].permit(:title, :body, :tag_list)
		@campaign = Campaign.new(vals)
		@campaign.user_id = current_user_id

		if @campaign.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit
		@campaign = Campaign.find(params[:id])
		if @campaign.user_id != current_user_id
			return redirect_to @campaign, notice: "Not owner of campaign"
		end
	end

	def update
		@campaign = Campaign.find(params[:id])
		
		if @campaign.user_id != current_user_id
			return redirect_to @campaign, notice: "Not owner of campaign"
		end

		vals = params[:campaign].permit(:title, :body, :tag_list)
		@campaign.update(vals)

		if @campaign.save
			redirect_to @campaign, notice: "Changes saved"
		else
			render 'edit'
		end
	end
end
