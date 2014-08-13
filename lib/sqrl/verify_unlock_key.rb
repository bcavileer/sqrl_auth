require 'sqrl/key'
require 'sqrl/diffie_hellman_ecc'
require 'rbnacl'

module SQRL
  class VerifyUnlockKey < Key
    def initialize(identity_lock_key, random_lock_key)
      super DiffieHellmanECC.verify_key(
        DiffieHellmanECC.shared_secret(identity_lock_key, random_lock_key))
    end

    def valid?(urs, message)
      RbNaCl::VerifyKey.new(@bytes).verify(urs, message)
    # rbnacl raises in a slight breeze
    rescue StandardError => e
      p e
      false
    end
  end
end
