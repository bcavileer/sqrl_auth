require 'sqrl/key'
require 'sqrl/server_unlock_key'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class RandomLockKey < Key
    def initialize(bytes = SecureRandom.random_bytes(32))
      super(bytes)
    end

    def identity_lock_key
      ServerUnlockKey.new(DiffieHellmanECC.public_key(@bytes))
    end
  end
end
