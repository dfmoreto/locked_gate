require 'jwt'
require_relative './base'
require_relative '../authentication_error'

module LockedGate
  module AuthStrategies
    class JWT < Base
      expiration do
        expiration_key = configuration.expiration_param.to_s
        Time.zone.at(decoded_token.first[expiration_key])
      end

      user_info do
        { id: decoded_token.first['uid'], email: decoded_token.first['email'] }
      end

      authentication do
        validate_expiration!
      rescue ::JWT::DecodeError
        raise AuthenticationError.new(:invalid_token, 'Invalid token')
      end

      private

      def validate_expiration!
        raise AuthenticationError.new(:expired_token, 'Token expired') if expiration < Time.zone.now
      end

      def decoded_token
        return @decoded_token if @decoded_token.present?

        @decoded_token = ::JWT.decode(@token, nil, false)
      end
    end
  end
end
