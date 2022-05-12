module LockedGate
  class Configuration
    HeaderConfig = Struct.new(:regex, :match)

    private_constant :HeaderConfig

    attr_reader :post_param, :query_string_param, :expiration_param, :header_config

    def initialize
      @post_param = @query_string_param = :token
      @expiration_param = :exp
      @header_config = HeaderConfig.new(/Bearer (.*)\s?/, '\1')
    end

    def post_key(key)
      @post_param = key
    end

    def query_string_key(key)
      @query_string_param = key
    end

    def expiration_key(key)
      @expiration_param = key
    end

    def header_regex(regex: nil, match: '')
      @header_config.regex = regex unless regex.nil?
      @header_config.match = match unless match.empty?
    end
  end
end
