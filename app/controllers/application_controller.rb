
class ApplicationController < ActionController::Base
 	before_filter :authenticate_user!
 # protect_from_forgery
	  

  

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
      puts "this is my application"
     end
   end
  
  def after_sign_in_path_for(resource)
    #user_dashboard_path(resource)
    #new_audit_finding_path(@audit.id)
    dashboards_path
    end
  

    
end
