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

    def header_regex(regex: //, match: '\1')
      @header_config = HeaderConfig.new(regex, match)
    end
  end
end
