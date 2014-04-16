require 'sqrl/identity_master_key'

module SQRL
  class ServerKey < IdentityMasterKey
    def initialize(bytes = SecureRandom.random_bytes(16))
      super(bytes)
    end
  end
end
