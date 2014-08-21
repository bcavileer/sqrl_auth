require 'spec_helper'
require 'sqrl/key/identity_unlock'

describe SQRL::Key::IdentityUnlock do
  subject {SQRL::Key::IdentityUnlock.new('x'.b*32)}
  it {expect(subject.b).to eq('x'.b*32)}
  it {expect(subject.identity_lock_key).to be_kind_of(SQRL::Key::IdentityLock)}
end
