module CustomApi
  class ApiController < ApplicationController
    before_action :authenticate_user!

    gate_unlock_configuration do |config|
      config.expiration_key :expiration
      config.param_key :api_token
      config.capture_token_on_header with: proc { |headers| headers['Authorization'].gsub(/api_token (\w+)/, '\1') }
    end
  end
end
