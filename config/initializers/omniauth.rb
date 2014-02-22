if Rails.env.production?
	# http://emo-song.herokuapp.com/
	FACEBOOK_KEY = "652487931453416"
	FACEBOOK_SECRET = "30a5edfb49121fdc5a09a59e58e7461a"
else
	# http://localhost:3000/
	FACEBOOK_KEY = "652487931453416"
	FACEBOOK_SECRET = "30a5edfb49121fdc5a09a59e58e7461a"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET,
  		   :display => 'page',
           :scope => 'read_stream,publish_stream'
end
