#
#  Request.rb
#  LhpArticleUploader
#
#  Created by Craig Williams on 2/17/13.
#  Copyright 2013 Craig Williams. All rights reserved.
#

# Initialize -> requires the calling class to implement
#
# two methods: success & failure

require 'json'
require 'uri'
require 'net/http'

class Request
  BASE_URL = "http://not-a-website.net/api/articles"
  TOKEN    = 'not-a-token'

  def initialize(params, requester)
    @caller = requester
    @params = params
  end

  def send
    uri = URI.parse BASE_URL
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)

    request["Content-Type"] = "application/json"
    request['Authorization'] = "Token token=#{TOKEN}"
    request.body = JSON.generate(@params)

    response = http.request(request)

    case response
    when Net::HTTPOK
      @caller.send(:success)
    else
      @caller.send(:failure)
    end

    response
  end
end
