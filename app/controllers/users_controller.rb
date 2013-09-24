class UsersController < ApplicationController
	before_action :require_login, only: [:edit, :update]
	def new
		@user = User.new
	end

	def create
		@user = User.new(params.require(:user).permit(:full_name, :email, :bio, :tag_list, :password))
		@user.gravatar = Digest::MD5.hexdigest(@user.email)
		
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@tags = UserCategorization.where(user_id: @user.id).joins(:category).select("*").order("score desc")
		@campaigns = Campaign.where(user_id: @user.id).limit(10)
		@feedback = Feedback.where(user_id: @user.id).joins(:campaign).select("*").limit(10)
	end
end
