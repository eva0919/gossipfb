if Rails.env.production?
	# http://emo-song.herokuapp.com/
	FACEBOOK_KEY = "151816211672168"
	FACEBOOK_SECRET = "c5be30e6eafd6691919ebfdc1b2ac3b4"
else
	# http://localhost:3000/
	FACEBOOK_KEY = "405855366115990"
	FACEBOOK_SECRET = "51676d9da8b7d134f8837d582ee1fe03"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET,
  		   :display => 'page',
           :scope => 'read_stream,publish_stream'
end
