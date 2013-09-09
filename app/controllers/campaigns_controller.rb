class CampaignsController < ApplicationController
	before_action :require_login

	def show
		campaign = Campaign.find(params[:id])

		if campaign.is_public
			@campaign = campaign
		else
			if campaign.user_id == session[:user_id]
				@campaign = campaign
			else
				redirect_to root_path, notice: "Private campaign."
			end
		end	
	end

	def new
		@campaign = Campaign.new
	end

	def create
		vals = params[:campaign].permit(:title, :body, :list_type, :confirm_deadline_days, :feedback_deadline_days)
		@campaign = Campaign.new(vals)
		@campaign.user_id = session[:user_id]

		if @campaign.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	private
	def require_login
		unless logged_in?
			redirect_to root_path, notice: "Must be logged in"
		end
	end
end
