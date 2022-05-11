module LockedGate
  class AuthenticationError < StandardError
    attr_reader :key

    def initialize(error_key, message)
      super(message)
      @key = error_key
    end
  end
end
