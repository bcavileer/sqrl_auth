require 'sqrl/key'
require 'sqrl/identity_lock_key'
require 'rbnacl'

module SQRL
  class IdentityUnlockKey < Key
    def initialize(bytes = SecureRandom.random_bytes(32))
      super(bytes)
    end

    def identity_lock_key
      IdentityLockKey.new(RbNaCl::SigningKey.new(@bytes).verify_key)
    end
  end
end
