require 'sqrl/key'
require 'sqrl/random_lock_key'
require 'sqrl/verify_unlock_key'

module SQRL
  class IdentityLockKey < Key
    def unlock_pair
      random = RandomLockKey.new
      [random.server_unlock_key, VerifyUnlockKey.new(self, random)]
    end
  end
end
