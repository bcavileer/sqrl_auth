require 'spec_helper'
require 'sqrl/identity_master_key'

describe SQRL::IdentityMasterKey do
  subject {SQRL::IdentityMasterKey.new('x'.b*32)}
  it {expect(subject.to_bytes).to eq('x'.b*32)}
  it {expect(subject.to_s).to eq('x'.b*32)}
  it {expect(subject.to_str).to eq('x'.b*32)}
  it {subject.wipe!; expect(subject.to_bytes).to eq("\0".b*32)}
end
