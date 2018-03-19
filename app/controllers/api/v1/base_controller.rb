class Api::V1::BaseController < Api::BaseController

  def_param_group :pagination do
    param :page, String, "Number of page. Default is 1"
    param :limit, String, "Pagination limit. Default is 10."
  end

  before_action :authenticate_with_token!

  # = Exception Notification
  rescue_from Exception do |exception|
    logger.error exception.class
    logger.error exception.message
    logger.error exception.backtrace.join "\n"
    @exception = exception


    case exception
      when Errors::MissingParameter, ActionController::ParameterMissing,
          ActiveRecord::DeleteRestrictionError, Orbita::Errors::UnprocessableEntity
        present_error 422, @exception, exception.class.name

      when AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, ActionController::RoutingError
        present_error 404, @exception, exception.class.name

      when Errors::NotAllowed, Orbita::Errors::Forbidden
        present_error 403, @exception, exception.class.name

      when Errors::BadAccessToken, Orbita::Errors::Unauthorized, Errors::NotAuthorized
        present_error 401, @exception, exception.class.name

      when Orbita::Errors::ApplicationError
        present_json({
                         backtrace: @exception.backtrace,
                         message: @exception.message,
                         class: @exception.class.name
                     }, 500, {base: [@exception.message]}, exception.class.name)

      # Catch Orbita base error (422 again)
      when Orbita::Errors::Error
        present_error 422, @exception, exception.class.name

      else
        present_json({
                         backtrace: @exception.backtrace,
                         message: @exception.message,
                         class: @exception.class.name
                     }, 500, {base: [@exception.message]}, Codes::APPLICATION_ERROR)
    end
  end
  # = Exception Notification

  def self.example_tag_path(tag)
    Rails.root.join "spec/controllers/api/v1/examples/#{tag}.json"
  end

  def self.serialize_array(array, serializer, scope = nil)
    ActiveModelSerializers::SerializableResource.new(array, each_serializer: serializer, scope: scope)
  end

  def self.serialize_record(resource, serializer, scope)
    ActiveModelSerializers::SerializableResource.new(resource, each_serializer: serializer, scope: scope)
  end

  protected

  def default_pagination_limit
    10
  end

  def authenticate_with_token!
    if request.headers['X-Auth-Token'].present?
      user_token = request.headers['X-Auth-Token']
      user = User.find_by_o51_authentication_token(user_token.to_s)
      unless user.nil?
        session[:user_id] = user.id
      else
        raise Errors::NotAuthorized.new 'You are not authorized to access this resource'
      end
    else
      raise Errors::NotAuthorized.new 'You are not authorized to access this resource'
    end
  end

  def serialize_resources(collection, serializer, scope = nil)
    present_json collection, 200, [], Codes::OK, serializer, scope
  end
  alias_method :serialize_resource, :serialize_resources

  def present_json(response, status = 200, errors = [], error_code = Codes::OK, serializer = nil, serializer_scope = nil)
    if serializer.nil?
      result = response
    else
      if response.respond_to?(:each)
        result = serialize_array(response, serializer, serializer_scope)
      else
        result = serialize_record response, serializer, serializer_scope
      end
    end

    r = {
        result: result,
        errors: errors,
        code: error_code,
        meta: {}
    }

    r[:meta][:pagination] = pagination_information(response) if response.respond_to?(:total_count)

    render json: r, status: status
  end

  def serialize_array(array, serializer, scope = nil)
    self.class.serialize_array array, serializer, scope
    # ActiveModelSerializers::SerializableResource.new(array, each_serializer: serializer, scope: scope)
  end

  def serialize_record(resource, serializer, scope)
    self.class.serialize_record resource, serializer, scope
    # ActiveModelSerializers::SerializableResource.new(array, each_serializer: serializer, scope: scope)
  end

  def pagination_information(collection)
    {
        total_count: collection.total_count,
        total_pages: collection.total_pages,
        current_page: params.fetch(:page, 1).to_i
    }
  end

  def present_errors(object)
    present_json({}, 422, object.errors.messages, Codes::VALIDATION_FAILED)
  end

  def present_error(status, exception, code)
    present_json({}, status, { base: [exception.message] }, code)
  end

  def serialize_errors(object)
    object.errors.messages.collect { |k, v| [k,v].join(' ') }
  end

  def require_params(*list)
    list.each do |p|
      unless params.has_key?(p)
        # present_json({}, 422, ['Please initialize your device with a Hello request first'], Codes::MISSING_PARAMETER)
        raise Errors::MissingParameter.new "Missing parameter #{p}"
      end
    end
  end

  def self.example_tag(tag, description = nil)
    e = File.read(example_tag_path(tag))
  rescue Errno::ENOENT
    e = "EXAMPLE #{example_tag_path(tag)} MISSING"
  ensure
    et = "# " + [description || "Example for #{tag}", e].join("\n\n")
    self.example(et)
  end

  # def enforce_params(list = [])
  #   list.each do |p|
  #     unless params.has_key?(p)
  #       # present_json({}, 422, ['Please initialize your device with a Hello request first'], Codes::MISSING_PARAMETER)
  #       raise Errors::MissingParameter.new "Missing parameter #{p}"
  #     end
  #   end
  # end

end
