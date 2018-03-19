class Api::BaseController < ApplicationController

  # Application codes
  # Can be used to better understand the error codes returned by the application
  # without the need to understand serialized error messages. Useful for the API client code.
  module Codes
    OK                  = 'ok'

    # Errors
    # MISSING_PARAMETER   = 'error.missing_parameter'
    VALIDATION_FAILED   = 'error.validation_failed'
    # NOT_ALLOWED         = 'error.not_allowed'
    # NOT_FOUND           = 'error.not_found'
    # UNAUTHORIZED        = 'error.unauthorized'

    APPLICATION_ERROR   = 'error.application_error'
  end

  module Errors
    class MissingParameter < StandardError ; end
    class NotAuthorized < StandardError ; end
    class NotAllowed < StandardError ; end
    class BadParameter < StandardError ; end
    class BadAccessToken < StandardError ; end
  end

  skip_before_action :ensure_user_is_signed_in!
end
