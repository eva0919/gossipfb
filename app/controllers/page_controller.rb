class PageController < ApplicationController
  require 'net/http'
  require "open-uri"
  include RestGraph::RailsUtil
  before_filter :login_facebook, :only => [:login]
  before_filter :load_facebook, :except => [:login]

  def index
    @access_token = rest_graph.access_token

    if @access_token
    	# @me = rest_graph.get('100001152400388',:fields=>"feed")
   #    # @me = rest_graph.get('/100001724550434/posts')
   #    puts "\n\n    >>>>>>>>>>>>>  \n\n"
   # #    @id = "100001724550434"
   # #    @limit = 50
	  # # # sql = "SELECT post_id, message, created_time FROM stream WHERE source_id = #{@id} AND message AND (type = 46 OR type = 80 OR type = 128 OR type = 247 OR type = 237 OR type = 257 OR type = 285) LIMIT #{@limit}"
   # #    sql = "SELECT text FROM comment WHERE fromid = #{@id} "
   # #    # @me = rest_graph.fql(sql)
   # 	  @d = @me["feed"]["paging"]["previous"]
   # 	  puts @d.split("&").each do {|x|
   # 	  	if x.include? ""
   # 	  }
   #    puts 
   		url = "https://graph.facebook.com/100001724550434?fields=feed&access_token=#{@access_token}"
     	data = open(url,{ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE}).read
     	json_data = JSON.parse(data)
     	puts "\n\n  >>>>>>  \n\n"
     	puts json_data.to_json
      # puts "\n\n    >>>>>>>>>>>>>  \n\n"
   #    @graph = Koala::Facebook::API.new(@access_token)
   #    @fql = @graph.fql_query(sql)
   #    puts @fql
   #   # url_t = "https://graph.facebook.com/100001724550434?fields=posts&access_token=#{@access_token}"
   #   # url = URI.parse(url_t)
   #   # req = Net::HTTP::Get.new(url.path)
   #   # res = Net::HTTP.start(url.host, url.port) {|http|
   #   #   http.request(req)
   #   # }
   #   # puts res.body
    else
    	redirect_to "/login"
    end
	

  end

  def login
    redirect_to '/'
  end

  def logout
    reset_session
    redirect_to '/'
  end

  def checkin
    unless rest_graph.access_token.nil?
      # logged in
      place_id = "152222568167545"
      location = { :latitude => "25.019588", :longitude => "121.541722" }
      tag = ""
      message = "La la la!"
      rest_graph.post('/me/checkins', :place => place_id,
                                      :coordinates => location,
                                      :tags => tag,
                                      :message => message)
    end

    redirect_to '/', :notice => 'Checked in CCSP!'
  end

private
  def load_facebook
    rest_graph_setup(:write_session => true)
  end

  def login_facebook
    rest_graph_setup(:auto_authorize         => true,
                     :auto_authorize_scope   => 'publish_checkins',
                     :ensure_authorized      => true,
                     :write_session          => true)
  end
end
