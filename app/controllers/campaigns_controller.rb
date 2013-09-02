class CampaignsController < ApplicationController
	def index
		@campaigns = Campaign.all;
	end

	def create
		@campaign = Campaign.new(params.require(:campaign).permit(:title, :body, :confirm_deadline, :feedback_deadline))

		if (@campaign.save)
			redirect_to campaigns_path
		else
			render 'index'
		end
	end
end
