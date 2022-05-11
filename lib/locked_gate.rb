require 'locked_gate/version'
require 'locked_gate/railtie'
require 'locked_gate/configuration'

module LockedGate
  def self.included(base)
    base.extend ClassMethods
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
      @custom_locked_gate_configuration = LockedGate.configuration
      block.call(@custom_locked_gate_configuration)
    end

    def custom_locked_gate_configuration
      @custom_locked_gate_configuration ||= LockedGate.configuration
    end
  end
end
