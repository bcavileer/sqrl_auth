require 'rbnacl'

module SQRL
  class Key
    class Site
      def initialize(imk, host)
        imk = imk.b
        unless imk.length == 32
          raise ArgumentError, "keys must be 32 bytes #{bytes.length})"
        end
        @private_key = RbNaCl::SigningKey.new(RbNaCl::HMAC::SHA256.auth(imk, host))
        @public_key = @private_key.verify_key.to_s
      end

      attr_reader :public_key

      def signature(message)
        @private_key.sign(message)
      end
    end
  end
end
