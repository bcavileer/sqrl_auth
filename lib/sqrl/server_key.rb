require 'sqrl/key'

module SQRL
  class ServerKey < Key
    def initialize(bytes = SecureRandom.random_bytes(16))
      super(bytes)
    end
  end
end
