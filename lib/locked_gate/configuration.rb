module LockedGate
  class Configuration
    attr_reader :expiration_param, :token_header_capture_block, :token_params_capture_block

    def initialize
      @expiration_param = :exp

      @token_params_capture_block = proc do |params|
        params[:token]
      end

      @token_header_capture_block = proc do |headers|
        headers['Authorization'].gsub(/(?:Bearer|Token) (.*)\s?/, '\1')
      end
    end

    def capture_token_on_header(with: nil)
      @token_header_capture_block = with unless with.nil?
    end

    def capture_token_on_params(with: nil)
      @token_params_capture_block = with unless with.nil?
    end

    def expiration_key(key)
      @expiration_param = key
    end

    def param_key(key)
      capture_token_on_params with: proc { |params| params[key] }
    end
  end
end
