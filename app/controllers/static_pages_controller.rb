class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		redirect_to patients_path
  	end
  end

  def help
  end
end
