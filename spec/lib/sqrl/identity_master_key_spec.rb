require 'spec_helper'
require 'sqrl/identity_master_key'

describe SQRL::IdentityMasterKey do
  subject {SQRL::IdentityMasterKey.new('x'*32)}
  it {expect(subject.to_bytes).to eq('x'*32)}
  it {expect(subject.to_s).to eq('x'*32)}
  it {expect(subject.to_str).to eq('x'*32)}
  it {subject.wipe!; expect(subject.to_bytes).to eq("\0"*32)}
end
