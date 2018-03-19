class Api::V1::SystemController < Api::V1::BaseController
  skip_before_action :authenticate_with_token!
  api :GET, '/system/status', "Sanity check on the application exposing this API"
  example_tag 'system/status'
  def status
    present_json({ status: 'ok', t: Time.now.to_i })
  end
end
