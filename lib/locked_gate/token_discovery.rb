module LockedGate
  class TokenDiscovery
    def initialize(configuration, params: {}, headers: {})
      @configuration = configuration
      @params = params
      @headers = headers
    end

    def token
      return @token if @token.present?

      @token = discover_from_header
      @token ||= discover_from_query_string
      @token ||= discover_from_post_param
    end

    private

    def discover_from_header
      return nil unless @headers.key?('Authorization')

      @headers['Authorization'].gsub(@configuration.header_regex, @configuration.header_match)
    end

    def discover_from_query_string
      token_name = @configuration.query_string_param.to_sym
      @params[token_name]
    end

    def discover_from_post_param
      token_name = @configuration.post_param.to_sym
      @params[token_name]
    end
  end
end
