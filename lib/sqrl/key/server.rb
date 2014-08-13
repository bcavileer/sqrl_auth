require 'sqrl/key'

module SQRL
  class Key
    class Server < Key
      def initialize(bytes = SecureRandom.random_bytes(16))
        super(bytes)
      end
    end
  end
end
