require 'sqrl/key'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class UnlockRequestSigningKey < Key
    def initialize(server_unlock_key, identity_unlock_key)
      super DiffieHellmanECC.shared_secret(server_unlock_key, identity_unlock_key)
    end
  end
end
