require 'sqrl/key'
require 'sqrl/diffie_hellman_ecc'

module SQRL
  class VerifyUnlockKey < Key
    def initialize(identity_lock_key, random_lock_key)
      super DiffieHellmanECC.public_key(
        DiffieHellmanECC.shared_secret(identity_lock_key, random_lock_key))
    end
  end
end
