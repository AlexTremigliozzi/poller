module Orbita
  module Errors

    class Error < StandardError ; end

    # 401
    class Unauthorized < Error ; end

    # 403
    class Forbidden < Error ; end

    # 422
    class UnprocessableEntity < Error ; end

    # 500
    class ApplicationError < Error ; end
  end
end
