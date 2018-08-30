class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :track_action
  before_action :set_notifications, if: :user_signed_in?
  before_action :set_paper_trail_whodunnit

    def api_current_user
      @current_user ||= User.where(id: session[:user_id]).first
    end
    helper_method :api_current_user


  # def current_user
  #   @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  # end

  # helper_method :current_user

  def set_notifications
      @notifications = Notification.where(recipient: current_user).recent
  end

  protected

   def track_action
     if controller_name != "notifications"
       ahoy.track "Viewed #{controller_name}##{action_name}"
    end
   end


end
