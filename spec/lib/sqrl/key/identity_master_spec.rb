require 'spec_helper'
require 'sqrl/key/identity_master'

describe SQRL::Key::IdentityMaster do
  subject {SQRL::Key::IdentityMaster.new('x'.b*32)}
  it {expect(subject.b).to eq('x'.b*32)}
  it {expect(subject.to_s.length).to eq(43)}
  it {subject.wipe!; expect(subject.b).to eq("\0".b*32)}
end
