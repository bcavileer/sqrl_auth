require 'spec_helper'
require 'sqrl/opaque_nut'

describe SQRL::OpaqueNut do
  subject {SQRL::OpaqueNut.new}
  it {expect(subject.to_s).to be_a(String)}
  it {expect(subject.to_s.length).to eq(27)}
  it {expect(subject.to_string.length).to eq(27)}
end
