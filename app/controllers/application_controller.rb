class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_user , :prepare_exception_notifier

 private
 def prepare_exception_notifier
   request.env["exception_notifier.exception_data"] = {
     :current_user => current_user
   }
 end

 # Gets the unread messages for the logged in user
 def check_user

   if (user_signed_in? || admin_signed_in?)
     @navigation='true'
     if user_signed_in?
       @loggedin_user= current_user.id
     else
       @loggedin_user=current_admin.id
     end
     else
     @navigation='false'
   end
 end
end
