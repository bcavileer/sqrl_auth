require 'spec_helper'
require 'sqrl/key/identity_master'

describe SQRL::Key::IdentityMaster do
  subject {SQRL::Key::IdentityMaster.new('x'.b*32)}
  it {expect(subject.to_bytes).to eq('x'.b*32)}
  it {expect(subject.to_s).to eq('x'.b*32)}
  it {expect(subject.to_str).to eq('x'.b*32)}
  it {subject.wipe!; expect(subject.to_bytes).to eq("\0".b*32)}
end
