require 'sqrl/key'
require 'sqrl/identity_lock_key'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class IdentityUnlockKey < Key
    def initialize(bytes = SecureRandom.random_bytes(32))
      super(bytes)
    end

    def identity_lock_key
      IdentityLockKey.new(DiffieHellmanECC.public_key(@bytes))
    end
  end
end
