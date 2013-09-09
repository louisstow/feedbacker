class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(params.require(:user).permit(:full_name, :email, :bio, :tag_list, :password))
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		
	end
end
