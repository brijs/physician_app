class SessionsController < ApplicationController
	def new

	end

	def create
		physician = Physician.find_by_email(params[:session][:email])
		if physician && physician.authenticate(params[:session][:password])
			sign_in physician
			redirect_back_or static_pages_home_path
		else
			flash.now[:error] = "Invalid email or password combination"
			# since we are not redirecting, we need to use flash.now, so that flash
			# is forgotten when the next page is loaded
			render 'new'
		end

	end

	def destroy
		sign_out
		redirect_to root_path
	end

end
