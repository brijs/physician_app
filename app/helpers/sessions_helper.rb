module SessionsHelper
	# all methods defined below (** helper methods**) are automatically accessible
	# from various views by default, and by various controllers (after include 
	# statements).

	def sign_in (physician)
		cookies.permanent[:remember_token] = physician.remember_token
		current_physician = physician
		# note: above calls the assignment method(helper function below)
	end
	
	def current_physician=(physician)
		current_physician = physician
	end

	def current_physician
		current_physician ||= physician_from_remember_token
	end

	def current_physician?(physician)
		physician == current_physician
	end	
	
	def physician_from_remember_token
		# token below is supplied by the browser
		remember_token = cookies[:remember_token]
		Physician.find_by_remember_token(remember_token) unless remember_token.nil?
	end

	def signed_in?
		!current_physician.nil?
	end

	def sign_out
		current_physician = nil
		cookies.delete(:remember_token)
	end

	def signed_in_physician
		if !signed_in?
			store_location
			redirect_to signin_path, notice: "Please sign in." 
		end
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end

	def store_location
		session[:return_to] = request.fullpath
	end

	private
	def clear_return_to
		session.delete(:return_to)
	end
	
end
