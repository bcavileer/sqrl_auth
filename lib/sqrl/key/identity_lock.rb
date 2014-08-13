require 'sqrl/key'
require 'sqrl/key/random_lock'
require 'sqrl/key/verify_unlock'

module SQRL
  class Key
    class IdentityLock < Key
      def unlock_pair
        random = RandomLock.new
        [random.server_unlock_key, VerifyUnlock.generate(self, random)]
      end
    end
  end
end
