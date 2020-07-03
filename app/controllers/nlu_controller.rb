class NluController < ApplicationController

	def index
	require 'net/http'
	require 'uri'

	uri = URI.parse("https://gateway.watsonpatform.net/natural-language-understanding/api/v1/analyze?version=2018-03-16")
	request = Net::HTTP::Post.new(uri)
	request.basic_auth("712ce569-6972-4162-b66f-3ac218f5a623", "kcA4GWbvTZpt")
	request.content_type = "application/json"
	request.body = '{
  "text": "IBM is an American multinational technology company headquartered in Armonk, New York, United States, with operations in over 170 countries.",
  "features": {
    "entities": {
      "emotion": true,
      "sentiment": true,
      "limit": 2
    },
    "keywords": {
      "emotion": true,
      "sentiment": true,
      "limit": 2
    }
  }
}'.to_json
p uri.hostname
p uri.path
p uri.port

	#request.body << File.read("parameters.json").delete("\r\n")

	req_options = {
	  use_ssl: uri.scheme == "https",
	}

	response = Net::HTTP.start('https://gateway.watsonpatform.net/natural-language-understanding/api/v1/analyze?version=2018-03-16', req_options) do |http|
	  http.request(request)
	end

	p response.code
	p response.body
	render  response.body
	end
end
