require 'sqrl/key'
require 'sqrl/key/identity_lock'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class Key
    class IdentityUnlock < Key
      def initialize(bytes = SecureRandom.random_bytes(32))
        super(bytes)
      end

      def identity_lock_key
        IdentityLock.new(DiffieHellmanECC.public_key(@bytes))
      end
    end
  end
end
