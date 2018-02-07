class HomeController < ApplicationController
  def index
    if user_signed_in?
        redirect_to polls_path
    else
        redirect_to new_user_session_path
    end
  end

  def user_mention
    render json: User.all, root: false
  end



end
