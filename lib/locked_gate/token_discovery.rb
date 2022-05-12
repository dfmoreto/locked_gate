require 'locked_gate/authentication_error'

module LockedGate
  class TokenDiscovery
    def initialize(configuration, params: {}, headers: {})
      @configuration = configuration
      @params = params
      @headers = headers
    end

    def token
      return @token if @token.present?

      @token = discover_token_from_header
      @token ||= discover_token_from_params
      raise AuthenticationError.new(:empty_token, 'Empty token') if @token.nil?

      @token
    end

    private

    def discover_token_from_header
      @configuration.token_header_capture_block.call(@headers)
    rescue StandardError
      nil
    end

    def discover_token_from_params
      @configuration.token_params_capture_block.call(@params)
    rescue StandardError
      nil
    end
  end
end
