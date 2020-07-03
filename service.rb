
#!/usr/bin/env ruby

class PersonalityClass

def personality
require 'excon'
require 'uri'
require 'net/http'
require 'net/https'
require 'json'


    @endpoint =  "https://gateway.watsonplatform.net/personality-insights/api"
    @username = "6f2b9c4a-5fa9-475c-b58f-17fc0f4ec9dc"
    @password = "tq7m3DMryyjm"
 

    # Set default headers
    contentType= "text/plain;charset=UTF-8"
    contentLanguage= "en"
    acceptLanguage = "en"

    # Request the profile
data=""
    response = Excon.post(@endpoint + "/v3/profile?version=2017-10-13&consumption_preferences=true&raw_scores=true",
                        :body     => data,
                        :headers  => {
                          "Content-Type"     => contentType,
                          "Content-Language" => contentLanguage,
                          "Accept-Language"  => acceptLanguage
                        },
                        :user     => @username,
                        :password => @password)

    p response.body.to_json
     
   return response.body

end
end
