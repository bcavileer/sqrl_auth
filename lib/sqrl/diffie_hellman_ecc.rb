require 'rbnacl'

module SQRL
  module DiffieHellmanECC
    extend self

    def public_key(secret_key)
      RbNaCl::GroupElement.base.mult(secret_key).to_bytes
    end

    def verify_key(secret_key)
      RbNaCl::SigningKey.new(secret_key).verify_key.to_s
    end

    def shared_secret(public_key, secret_key)
      RbNaCl::GroupElement.new(public_key).mult(secret_key).to_bytes
    end
  end
end
