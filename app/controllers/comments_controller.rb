class CommentsController < ApplicationController

	def create
		@feedback = Feedback.find(params[:feedback_id])
		@comment = @feedback.comments.new(params[:comment].permit(:body))

		@comment.user_id = current_user_id

		if @comment.save
			redirect_to @feedback.campaign, notice: "Comment created"
		else
			redirect_to @feedback.campaign, notice: "Cannot create comment"
		end
	end
end
