require_relative './auth_strategies/jwt'

module LockedGate
  class Authentication
    def initialize(configuration, token)
      @configuration = configuration
      @token = token
    end

    def authenticate!
      auth_strategy = AuthStrategies::JWT.new(@configuration, @token)
      auth_strategy.authenticate!
      Key.attributes = { user: auth_strategy.user_data, token: auth_strategy.token, expiration: auth_strategy.expiration }
    end
  end
end
