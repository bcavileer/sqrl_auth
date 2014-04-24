require 'spec_helper'
require 'sqrl/reversible_nut'
require 'sqrl/server_key'

describe SQRL::ReversibleNut do
  let(:server_key) {SQRL::ServerKey.new}
  let(:ip) {'127.0.0.1'}
  subject {SQRL::ReversibleNut.new(server_key, ip)}
  it {subject.to_bytes.length.should == 16}
  it {subject.to_s.length.should == 22}
  it {subject.to_s.should_not match('=')}
  it {subject.response_nut.should be_a(SQRL::ReversibleNut)}
  it {SQRL::ReversibleNut.reverse(server_key, subject.to_s).ip.should == ip}
  it {SQRL::ReversibleNut.reverse(server_key, subject.to_s).timestamp.should == subject.timestamp}
end
