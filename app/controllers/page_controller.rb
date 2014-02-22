class PageController < ApplicationController

	# before_filter :parse_facebook_cookies
 #  def parse_facebook_cookies
 #    @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  
 #    # If you've setup a configuration file as shown above then you can just do
 #    # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
 #  end

  def index
    if session[:token]
			@graph = Koala::Facebook::API.new(session[:token])
			puts @graph.get_object("me")
	else
	   redirect_to	'/new'
	end
  end
end
