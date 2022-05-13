module CustomApi
  class CustomAuthenticatedController < ApiController
    gate_unlock_configuration do |config|
      config.expiration_key :custom_expiration
      config.param_key :custom_token
      config.capture_token_on_header with: proc { |headers| headers['Authorization'].gsub(/custom_token (\w+)/, '\1') }
    end

    def index
      head :ok
    end
  end
end
