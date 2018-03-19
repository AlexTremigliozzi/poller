class OmniauthCallbacksController < ApplicationController
  # This action will be called when returing from authentication process.
  # request.env['omniauth.auth'] will hold all informations.
  # Let's handle login process as a class method in User model
  def orbita
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted? # The user has been succesfully saved
      sign_in_and_redirect @user
    else
      # This should never happend, you should investigate otherwise
      redirect_to session[:last_path] || root_path
    end
  end
end
