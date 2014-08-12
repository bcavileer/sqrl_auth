require 'spec_helper'
require 'sqrl/identity_unlock_key'

describe SQRL::IdentityUnlockKey do
  subject {SQRL::IdentityUnlockKey.new('x'.b*32)}
  it {expect(subject.to_bytes).to eq('x'.b*32)}
  it {expect(subject.identity_lock_key).to be_kind_of(SQRL::IdentityLockKey)}
end
