module LockedGate
  class Key < ActiveSupport::CurrentAttributes
    attribute :user
    attribute :token
    attribute :expiration
  end
end
