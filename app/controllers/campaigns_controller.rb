class CampaignsController < ApplicationController
	before_action :require_login, only: [:create, :edit, :update, :destroy]

	def show
		@campaign = Campaign.find(params[:id])
		@feedbacks = Feedback.where(campaign_id: @campaign.id).joins(:user).order("rating desc, score desc")
	end

	def new
		if !logged_in?
			return redirect_to '/users/new', notice: "Please signup before creating a campaign"
		end
		@campaign = Campaign.new
	end

	def create
		vals = params[:campaign].permit(:title, :body, {:category_ids => []})
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

		@campaign.feedback.each do |f|
			Notification.create({user_id: f.user_id, body: "<span data-id='#{@campaign.id}'>Campaign, #{@campaign.title}, has been updated</span>"})
		end

		if @campaign.save
			redirect_to @campaign, notice: "Changes saved"
		else
			render 'edit'
		end
	end
end
