require 'spec_helper'
require 'sqrl/reversible_nut'
require 'sqrl/key/server'

describe SQRL::ReversibleNut do
  let(:server_key) {SQRL::Key::Server.new}
  let(:ip) {'127.0.0.1'}
  subject {SQRL::ReversibleNut.new(server_key, ip)}
  it {expect(subject.to_bytes.length).to eq(16)}
  it {expect(subject.to_s.length).to eq(22)}
  it {expect(subject.to_s).not_to match('=')}
  it {expect(subject.response_nut).to be_a(SQRL::ReversibleNut)}
  it {expect(SQRL::ReversibleNut.reverse(server_key, subject.to_s).ip).to eq(ip)}
  it {expect(SQRL::ReversibleNut.reverse(server_key, subject.to_s).timestamp).to eq(subject.timestamp)}
end
