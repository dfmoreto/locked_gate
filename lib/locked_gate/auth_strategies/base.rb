require 'jwt'
require_relative '../authentication_error'

module LockedGate
  module AuthStrategies
    class Base
      attr_reader :token

      def self.expiration(&block)
        define_method(:expiration, &block)
      end

      def self.user_info(&block)
        define_method(:user_info, &block)
      end

      def self.authentication(&block)
        define_method(:authenticate!, &block)
      end

      def initialize(configuration, token, *options)
        @configuration = configuration
        @token = token
        @options = options
      end

      def expiration
        nil
      end

      def user_info
        {}
      end

      def authenticate!
        false
      end

      protected

      attr_reader :configuration, :options
    end
  end
end
