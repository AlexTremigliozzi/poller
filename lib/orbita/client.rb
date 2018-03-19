module Orbita
  class Client
    include HTTParty

    attr_reader :config

    def initialize
      @config = Rails.application.secrets.oauth
    end

    def get_token(login, password)
      url = [config[:app_url], 'oauth/token'].join('/')
      params = {
          client_id: config[:client_id],
          client_secret: config[:client_secret],
          grant_type: "password",
          username: login,
          scope: config[:scope],
          password: password
      }
      handle_response self.class.post(url, body: params)
    end

    def me(token)
      url = [config[:app_url], 'api/v1', 'users/me'].join('/')
      headers = {'Authorization' => "Bearer #{token}"}
      handle_response self.class.get(url, headers: headers)
    end

    private
    def handle_response(response)
      case response.code
        when 200
          response.parsed_response.with_indifferent_access
        when 401
          raise Orbita::Errors::Unauthorized.new
        when 403
          raise Orbita::Errors::Forbidden.new
        when 422
          raise Orbita::Errors::UnprocessableEntity.new
        when 500
          raise Orbita::Errors::ApplicationError.new
        else
          raise Orbita::Errors::Error.new
      end
    end
  end
end
