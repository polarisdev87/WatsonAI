Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	 root :to => "personality#new"
	 post "personality/new"
         get "nlp/index"
         post "nlp/index"
         get "nlp/new"
         post "nlp/new"
				 get "personality/list/:id" , to: "personality#list"
         get "personality/list"
         get "nlp/list"
         get "personality/new"
         post "personality/new"
         post "personality/list"
          post "nlp/list"
         post "personality/inviteuser/" ,  to:  "personality#inviteuser"


end
