class SessionsController < ApplicationController
	def create
		auth = request.env["omniauth.auth"]
		session[:uid] = auth['uid']
		session[:token] = auth['credentials']['token']
		redirect_to root_url, :notice => "Signed in!"
	end

	def new
		redirect_to '/auth/facebook'
	end

	def destroy
		reset_session
		redirect_to root_url, :notice => 'Signed out'
	end
end
