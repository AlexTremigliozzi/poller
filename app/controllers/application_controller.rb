class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :track_action


  # def current_user
  #   @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  # end

  # helper_method :current_user

  protected

   def track_action
     if controller_name != "notifications"
       ahoy.track "Viewed #{controller_name}##{action_name}"
    end
   end


end
