require 'jwt'
require_relative '../authentication_error'

module LockedGate
  module AuthStrategies
    class Base
      attr_reader :token

      def initialize(configuration, token, *options)
        @configuration = configuration
        @token = token
        @options = options
      end

      def authenticate!
        false
      end

      def expiration
        Time.zone.now
      end

      def user_data
        {}
      end

      protected

      attr_reader :configuration, :options
    end
  end
end
