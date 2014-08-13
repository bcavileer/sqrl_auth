require 'spec_helper'
require 'sqrl/authentication_query_generator'
require 'sqrl/client_session'
require 'sqrl/key/identity_master'

describe SQRL::AuthenticationQueryGenerator do
  let(:url) {'sqrl://example.com/sqrl?nut=awnuts'}
  let(:imk) {SQRL::Key::IdentityMaster.new('x'.b*32)}
  let(:session) {SQRL::ClientSession.new(url, imk)}
  subject {SQRL::AuthenticationQueryGenerator.new(session, url)}

  it {expect(subject.post_path).to eq('https://example.com/sqrl?nut=awnuts')}
  it {expect(subject.server_string).to eq(url)}
  it {expect(subject.client_string).to match("ver=1\r\ncmd=\r\nidk=")}
  it {expect(subject.to_hash).to be_a(Hash)}
  it {expect(subject.to_hash[:server]).to eq('c3FybDovL2V4YW1wbGUuY29tL3Nxcmw_bnV0PWF3bnV0cw')}
  it {expect(subject.to_hash[:client]).to match(/\A[\-\w_]+\Z/)}
  it {expect(subject.to_hash[:ids]).to match(/\A[\-\w_]+\Z/)}
  it {expect(subject.to_hash[:ids]).to eq('XZ5woYS-hYisbx4kTDDXaH8hxiRuXjnWHojVhhaZB4wvC1-9HlLbXoIQwRSxcVaFWyPnYKmPpyjk5-J_2T9UCA')}
  it {expect(subject.to_hash.keys).to eq([:client, :server, :ids])}
  it {expect(subject.post_body).to be_a(String)}
  it {expect(subject.commands).to be_empty}

  describe "login command" do
    subject {SQRL::AuthenticationQueryGenerator.new(session, url).login!}
    it {expect(subject.commands).to include('login')}
    it {expect(subject.client_data[:cmd]).to eq('login')}
  end
end
