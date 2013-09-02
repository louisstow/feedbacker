class UsersController < ApplicationController
	def new
		@categories = Category.all.collect {|c| [ c.name, c.id ] }
	end

	def create
		
	end
end
