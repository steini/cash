# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time

  filter_parameter_logging :password, :login

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '219f1318a68ebbf601706abb474dfa6f'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def balance_style income, spending
    
    if income - spending < 0 
      style = "style=\"color:red\""
    else
      style = "style=\"color:green\""
    end
    style
  end
  
end
