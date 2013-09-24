class WelcomeController < ApplicationController
	def index
		@recent = Campaign.limit(10).order("created_at desc")
	end
end
