module LockedGate
  class Configuration
    attr_reader :post_param, :query_string_param, :expiration_param, :header_regex, :header_match

    def initialize
      @post_param = @query_string_param = :token
      @expiration_param = :exp
      @header_regex = /Bearer (.*)\s?/
      @header_match = '\1'
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

    def header_config(regex: nil, match: '')
      @header_regex = regex unless regex.nil?
      @header_match = match unless match.empty?
    end
  end
end
