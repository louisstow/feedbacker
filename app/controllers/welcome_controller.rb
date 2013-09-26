class WelcomeController < ApplicationController
	def index
		@recent = Campaign.limit(10).order("created_at desc")
		@backers = User.limit(10).order("score desc")
	end
end
