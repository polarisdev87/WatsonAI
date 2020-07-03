class PersonalityController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_admin!

def isEmail(str)
  return str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]\.)[a-zA-Z]{2,4}/)
end

def inviteuser
   params[:emailid].each do |email|
     if isEmail(email)
       User.invite!(:email => email, :first_name =>  email , :last_name=> email)
     end
  end
end

 def new
   if admin_signed_in? || user_signed_in

           if  params[:data]
                @endpoint =  "https://gateway.watsonplatform.net/personality-insights/api"
                @username = "7bc7c83e-6921-47d1-8cd4-4055dc45ec6f"
                @password = "11RWVs6stiie"


                # Set default headers
                contentType= "text/plain;charset=UTF-8"
                contentLanguage= "en"
                acceptLanguage = "en"

                # Request the profile
                data=params[:data]

                if (params[:html_value]=="true")
                	contentType= "text/html;charset=UTF-8"
                else
            	     contentType= "text/plain;charset=UTF-8"
                end

                @response = Excon.post(@endpoint + "/v3/profile?version=2017-10-13&consumption_preferences=true&raw_scores=true",
                                    :body     => data,
                                    :headers  => {
                                      "Content-Type"     => contentType,
                                      "Content-Language" => contentLanguage,
                                      "Accept-Language"  => acceptLanguage                       },
                                    :user     => @username,
                                    :password => @password)
                  @query=Query.create(user_id: @loggedin_user,module_type: 'personality', query: params[:data], total_count: JSON.parse(@response.body)['word_count'])
              #  puts @response.to_json+"hmmmmm"
                #@final=JSON.parse(@response.body)['word_count']
                @personality = JSON.parse(@response.body)['personality']
                  @personality.each_with_index do  |(key,value), index |
                        @trait_name=key["name"]
                        key["children"].each_with_index do |(key,value,index)|
                          Personality.create(query_id: @query.id , count: JSON.parse(@response.body)['word_count'] , cat_type: 'big5', user_id: @loggedin_user, category: "Big 5 - "+  @trait_name , name:  key["name"], percentile: key["percentile"])
                  end
                end
                @needs=JSON.parse(@response.body)['needs']
                @needs.each_with_index do  |(key,value), index |
                      @trait_name=key["name"]

                        Personality.create(query_id: @query.id , cat_type: 'needs', user_id: @loggedin_user, category: "Needs" , name:  key["name"], percentile: key["percentile"])


                 end
                @consumption_preferences=JSON.parse(@response.body)["consumption_preferences"]
                 @consumption_preferences.each_with_index do  |(key,value), index |
                 @category='Consumption Preferences - '+key["name"]
                  key["consumption_preferences"].each_with_index do |(key,value,index)|
                        Personality.create(query_id: @query.id , cat_type: 'consumption_preferences', user_id: @loggedin_user, category: @category , name:  key["name"], percentile: key["score"])
                  end
                end
                @values=JSON.parse(@response.body)["values"]
                @values.each_with_index do  |(key,value), index |
                    Personality.create(query_id: @query.id ,user_id: @loggedin_user, cat_type: 'values',  category:  key["category"] , name:  key["name"], percentile: key["percentile"])
                end

              #  puts  @personality

               #p @final
               render :nothing =>"true" #@response.body
           else

           end
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
