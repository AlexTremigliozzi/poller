class Api::V1::AuthController < Api::V1::BaseController

  skip_before_action :authenticate_with_token!
  skip_before_action :verify_authenticity_token


  api :POST, "/auth/orbita", "Authenticates to the application using Orbita OAuth provider"
  param :access_token, String, desc: 'Orbita access token', required: true
  example_tag 'auth/orbita'
  example_tag 'auth/orbita_error'
  def orbita
    require_params :access_token

    begin
      info = Orbita::Client.new.me(params[:access_token])
      user = User.create_with_orbita(info, params[:access_token])
      if user.persisted?
        present_json({access_token: user.authentication_token, type: user.type})
      else
        present_json({}, 422, user.errors.messages)
      end
    rescue RestClient::Unauthorized => e
      raise Errors::BadAccessToken.new "Access token is not valid"
    end
  end

end
