class PageController < ApplicationController
	include RestGraph::RailsUtil
	before_filter :login_facebook, :only => [:login]
	before_filter :load_facebook, :except => [:login]

	# before_filter :parse_facebook_cookies
 #  def parse_facebook_cookies
 #    @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  
 #    # If you've setup a configuration file as shown above then you can just do
 #    # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
 #  end

  	def index
  		@access_token = rest_graph.access_token
  		puts @access_token
  		puts "------------------------start-----------------------"
  		if @access_token
  			
	      	# @me = rest_graph.get('/me')
	      	# puts @me
	      	#### Mike // 找尋使用者的friend list 以下是針對做資料處理 block data 有兩個index  => name,id

	      	@i = 0 
	      	@friends = rest_graph.get('/me/friends').first
	      	@pictures_arr = []
	      	@friends[1].each do |data|
	      		pictures = Hash.new 
	      		pictures["id"] = data["id"].to_s
	      		pictures["name"] = data["name"].to_s
	      		pictures["pictures_url"] = rest_graph.get("#{pictures["id"]}", :fields=>'picture')['picture']['data']['url']
	      		@pictures_arr.append(pictures)
	      		@i = @i + 1
	      		if @i > 10
	      			break
	      		end
	      		# puts data["id"]
	      		# puts "  **  "

	      	end
	      	puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n\n"
	      	# puts rest_graph.get('hsiao.annedoo', :fields=>'posts')
	      	# puts rest_graph.get("#{pretty_girl}",:fields=>"photos")
	      	# sleep(1)
	      	puts @pictures_arr
	      	
	      	
	      	# puts rest_graph.get(pretty_girl, :fields=>'feed')
	      	# puts rest_graph.get("#{pretty_girl}/feed")
	      	puts "----------------------end-----------------------"
	  #     	@id = "100001724550434"
			# @limit = 50
			# sql = "SELECT post_id, message, created_time FROM stream WHERE source_id = #{@id} AND message AND (type = 46 OR type = 80 OR type = 128 OR type = 247 OR type = 237 OR type = 257 OR type = 285) LIMIT #{@limit}"
			# # sql = "SELECT name, description, is_deprecated FROM table WHERE 1"
			# # @me = rest_graph.fql(sql)
			# # puts @me
			# @graph = Koala::Facebook::API.new(@access_token)
			# @fql = @graph.fql_query(sql)
			# puts @fql
		else
			redirect_to "/login"
  		end




	    
 #    if session[:token]
 #    	puts ">>>>>>>>>>>><<<<<<<<<<<<<<<<>>>>>>>>>>>>>>><<<<<<<<<<<<<"
	# 	@graph = Koala::Facebook::API.new(session[:token])
	# 	# puts @graph.get_object("me")
	# 	profile = @graph.get_object("me")
	# 	friends = @graph.get_connections("me", "friends")
	# 	# @graph.put_connections("me", "feed", :message => "I am writing on my wall!")
	# 	# a =  @graph.get_object(friends[0]["id"])
	# 	# puts @graph.get_picture(friends[0]["id"])
	# 	puts @graph.get_object( "me", friends[0]["id"].to_s+"/photos")

	# else
	#    redirect_to	'/new'
	# end
    end

    def get_time
    	puts "   >>>>start  "
    	@access_token = rest_graph.access_token
    	pretty_girl_id = params[:user_id]
    	# pretty_girl_id = user_id
    	@photo_time = []
    	@post_time = []
		if @access_token
			puts pretty_girl_id
			@photo_time = rest_graph.get("#{pretty_girl_id}/photos", :fields=>'created_time')
			# puts @photo_time["data"]
			@post_time = rest_graph.get("#{pretty_girl_id}/posts", :fields=>'created_time')
			# puts @post_time["data"]
		else
			puts "wrong"
			redirect_to '/login'
		end
		@DateCount = Array.new(12){0}

		@photo_time["data"].each do | x |
			
			@DateCount[ (( Time.parse(x["created_time"]).hour ).to_i / 2).to_i ] += 1
		end 

		@post_time["data"].each do | x |
			
			@DateCount[ (( Time.parse(x["created_time"]).hour ).to_i / 2).to_i ] += 1
		end 
		
		puts @DateCount
		puts "   >>>>end  "

    end

    def login
	    redirect_to '/'
	end

	def logout
	    reset_session
	    redirect_to '/'
	end


	private
	  def load_facebook
	    rest_graph_setup(:write_session => true)
	  end

	  def login_facebook
	    rest_graph_setup(:auto_authorize         => true,
	                     :auto_authorize_scope   => 'read_friendlists, publish_stream',
	                     :ensure_authorized      => true,
	                     :write_session          => true)
	  end  	
	end
# end



