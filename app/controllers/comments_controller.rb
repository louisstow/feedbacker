class CommentsController < ApplicationController
	before_action :require_login, only: [:create, :destroy]

	def create
		@feedback = Feedback.find(params[:feedback_id])
		@comment = @feedback.comments.new(params[:comment].permit(:body))

		@comment.user_id = current_user_id

		Notification.create({user_id: @feedback.user_id, body: "<span data-id='#{@feedback.campaign.id}'>Comment left on your feedback</span>"})

		if @comment.save
			redirect_to @feedback.campaign, notice: "Comment created"
		else
			redirect_to @feedback.campaign, notice: "Cannot create comment"
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
		if current_user_id == @comment.user_id
			@comment.destroy
			redirect_to campaign_path(@comment.feedback.campaign_id), notice: "Comment deleted"
		else
			redirect_to campaign_path(@comment.feedback.campaign_id), notice: "Not owner of comment"
		end
	end
end
