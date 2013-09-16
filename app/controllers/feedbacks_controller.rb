class FeedbacksController < ApplicationController
	before_action :require_login, only: [:create, :edit, :destroy]

	def create
		@campaign = Campaign.find(params[:feedback][:campaign_id])
		@feedback = @campaign.feedback.new(params[:feedback].permit(:body))
		@feedback.user_id = session[:user_id]

		if @feedback.save
			redirect_to campaign_path(@feedback.campaign), notice: "Feedback saved"
		else
			redirect_to campaign_path(@feedback.campaign), notice: "Error creating feedbacks"
		end
	end

	def edit
	end

	def destroy
		@feedback = Feedback.find(params[:id])

		if @feedback.user_id != current_user_id
			redirect_to root_path, notice: "Cannot remove other feedback"
		end

		@feedback.destroy
		redirect_to campaign_path(@feedback.campaign), notice: "Feedback removed"
	end

	def report
	end
end
