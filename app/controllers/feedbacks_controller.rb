class FeedbacksController < ApplicationController
	before_action :require_login, only: [:create, :edit, :destroy, :update, :rate]

	def create
		@campaign = Campaign.find(params[:feedback][:campaign_id])

		if @campaign.feedback.find_by_user_id(current_user_id)
			return redirect_to @campaign, notice: "Edit your existing feedback"
		end

		if current_user_id == @campaign.user_id
			return redirect_to @campaign, notice: "Cannot leave feedback on your own campaign"
		end

		@feedback = @campaign.feedback.new(params[:feedback].permit(:body))
		@feedback.user_id = session[:user_id]

		# leave a notification for the owner
		Notification.create({user_id: @campaign.user_id, body: "<span data-id='#{@campaign.id}'>Feedback created on your campaign, #{@campaign.title}</span>"})

		if @feedback.save
			redirect_to @campaign, notice: "Feedback saved"
		else
			redirect_to @campaign, notice: "Error creating feedbacks"
		end
	end

	def update
		@feedback = Feedback.find(params[:id])
		if @feedback.user_id != current_user_id
			return redirect_to root_path, notice: "Cannot update feedback"
		end

		@feedback.update(params[:feedback].permit(:body))
		campaign = @feedback.campaign

		Notification.create({user_id: campaign.user_id, body: "<span data-id='#{campaign.id}'>Feedback updated on your campaign, #{campaign.title}</span>"})

		if @feedback.save
			redirect_to campaign, notice: "Feedback updated"
		else
			redirect_to campaign, notice: "Feedback could not be updated"
		end
	end

	def destroy
		@feedback = Feedback.find(params[:id])

		if @feedback.user_id != current_user_id
			return redirect_to root_path, notice: "Cannot remove other feedback"
		end

		# remove the earnt karma
		if @feedback.rating == 1
			@feedback.user.giveKarma!(-1)
		end

		campaign = @feedback.campaign
		Notification.create({user_id: campaign.user_id, body: "<span data-id='#{campaign.id}'>Feedback removed on your campaign, #{campaign.title}</span>"})

		@feedback.destroy
		redirect_to campaign, notice: "Feedback removed"
	end

	def report
	end

	def rate
		@feedback = Feedback.find(params[:feedback_id])

		if current_user_id != @feedback.campaign.user_id
			return redirect_to @feedback.campaign, notice: "Not owner of this campaign"
		end

		if params[:rating] == "good"
			rating = 1
		elsif params[:rating] == "bad"
			rating = -1
		else
			return redirect_to @feedback.campaign
		end

		if @feedback.rating == rating
			return redirect_to @feedback.campaign
		end

		karma = rating
		if @feedback.rating
			karma = rating * 2
		end

		@feedback.rating = rating
		@feedback.save

		# Give a karma point to feedback owner
		# Give a karma point for each category of owner
		@feedback.user.giveKarma!(karma)

		@feedback.campaign.categories.each do |cat|
			tag = UserCategorization.find_or_create_by(category_id: cat.id, user_id: @feedback.user_id)
			
			tag.increment(:score, karma)
			tag.save()
		end

		campaign = @feedback.campaign
		Notification.create({user_id: @feedback.user_id, body: "<span data-id='#{campaign.id}'>Your feedback recieved a #{params[:rating]} rating</span>"})

		redirect_to @feedback.campaign
	end
end
