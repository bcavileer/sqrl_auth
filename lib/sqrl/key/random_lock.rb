require 'sqrl/key'
require 'sqrl/key/server_unlock'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class Key
    class RandomLock < Key
      def initialize
        super(SecureRandom.random_bytes(32))
      end

      def server_unlock_key
        ServerUnlock.new(DiffieHellmanECC.public_key(@bytes))
      end
    end
  end
end
