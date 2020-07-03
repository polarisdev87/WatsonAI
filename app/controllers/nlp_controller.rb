class NlpController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_admin!

 def new
   if admin_signed_in? || user_signed_in

   if  params[:data]
    @endpoint =  "https://gateway.watsonplatform.net/natural-language-understanding/api"
    username = "d3195126-4fdd-4d3e-8a31-6457c7552208"
    password = "8Cp451cetvPT"
  	require 'rest-client'

    # Set default headers
    contentType= "Content-Type: application/json"
    contentLanguage= "en"
    acceptLanguage = "en"

    # Request the profile
    data=params[:data]
    if (params[:url_value]=="true")
	@type='url'
    else
	@type='text'
    end


#@content2=JSON.parse(@content)
@response = RestClient::Request.new({
      method: :post,
      url: @endpoint + '/v1/analyze/?version=2018-03-16',
      user: 'd3195126-4fdd-4d3e-8a31-6457c7552208',
      password: '8Cp451cetvPT',
      payload: {@type=>params[:data],features: {
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
  }}.to_json,
      headers: { :accept => :json, content_type: :json }
    }).execute do |response, request, result|
      case response.code
      when 400
        [ :error, response.to_str ]
      when 200
        [  response ]
      else
        fail "Invalid response #{response.to_str} received."
      end
    end
    @final_response=JSON.parse(@response)
    @query=Query.create(user_id: @loggedin_user,module_type: 'nlp', query: params[:data], total_count: @final_response["usage"]["text_characters"])

    @response.each_with_index do  |(key,value), index |

     Nlp.create(query_id: @query.id , cat_type: key["type"], user_id: @loggedin_user, sentiment: key["sentiment"]   , relevance:  key["relevance"], emotion: key["emotion"],description:key["text"],name: "",count: key["count"])
    end

  end
    #p @response
    require 'json2table' # if you've installed the gem

#require 'path/to/lib/json2table.rb'# if you've git clone'd the repo

table_options = {
  table_style: "border: 1px solid black; max-width: 600px;",
  table_class: "table table-striped table-hover table-condensed table-bordered",
  table_attributes: "border=1"
  }
  jsoned = @response[1].to_json

  @json2table =  Json2table::get_html_table(jsoned, table_options)
  #puts @json2table
   p JSON.parse(@response[1])["keywords"][0]["text"]
   @keywords = JSON.parse(@response[1])["keywords"]
   @entities=JSON.parse(@response[1])["entities"]
   return @response[1]
   else
   end
end

def list
  if params["id"]
     @query=Personality.where(["query_id = ? ", params["id"] ])
     @personality=@query.where(["cat_type= ? ", 'big5' ])
     @needs=@query.where(["cat_type= ? ", 'needs' ])
     @consumption_preferences=@query.where(["cat_type= ? ", 'consumption_preferences' ])
     @values=@query.where(["cat_type= ? ", 'values' ])
    p @consumption_preferences.inspect
  else


    @personality=Query.where("user_id= ?" , @loggedin_user)
     #puts @personality.inspect
  end
end

end
