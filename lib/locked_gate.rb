require 'locked_gate/version'
require 'locked_gate/engine'
require 'locked_gate/authentication'
require 'locked_gate/configuration'
require 'locked_gate/token_discovery'

module LockedGate
  def self.included(base)
    base.extend ClassMethods

    base.rescue_from LockedGate::AuthenticationError do |exception|
      render(json: { message: exception.message }, status: :unauthorized)
    end
  end

  def self.configure(&block)
    @configuration = Configuration.new
    block.call(@configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  module ClassMethods
    def gate_unlock_configuration(&block)
      define_method :custom_locked_gate_configuration do
        @custom_locked_gate_configuration ||= LockedGate.configuration.dup
        block.call(@custom_locked_gate_configuration)
        @custom_locked_gate_configuration
      end
    end
  end

  def custom_locked_gate_configuration
    @custom_locked_gate_configuration ||= LockedGate.configuration.dup
  end

  def authenticate_user!
    discovery = TokenDiscovery.new(custom_locked_gate_configuration, params: params, headers: request.headers)
    auth = Authentication.new(custom_locked_gate_configuration, discovery.token)
    auth.authenticate!
  end
end
