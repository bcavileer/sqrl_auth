require 'sqrl/key'
require 'sqrl/server_unlock_key'
require 'rbnacl'

module SQRL
  class RandomLockKey < Key
    def initialize(bytes = SecureRandom.random_bytes(32))
      super(bytes)
    end

    def identity_lock_key
      ServerUnlockKey.new(RbNaCl::SigningKey.new(@bytes).verify_key)
    end
  end
end
