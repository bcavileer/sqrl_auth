require 'rbnacl'

module SQRL
  module DiffieHellmanECC
    extend self

    def public_key(secret_key)
      secret_key = validate(secret_key, 'secret key')
      RbNaCl::GroupElement.base.mult(secret_key).to_bytes
    end

    def shared_secret(public_key, secret_key)
      public_key = validate(public_key, 'public key')
      secret_key = validate(secret_key, 'secret key')
      RbNaCl::GroupElement.new(public_key).mult(secret_key).to_bytes
    end

    private
    def validate(key, name)
      key = key.b
      unless key.length == 32
        raise ArgumentError, "#{name} must be 32 bytes #{key.length})"
      end
      key
    end
  end
end
