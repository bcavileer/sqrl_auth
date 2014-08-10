require 'spec_helper'
require 'sqrl/identity_master_key'
require 'sqrl/client_session'
require 'sqrl/authentication_response_parser'

describe SQRL::AuthenticationResponseParser do
  let(:imk) {SQRL::IdentityMasterKey.new('x'*32)}
  let(:nut) {'1vwuE1aBqyOHCg9yqVDhnQ'}
  let(:url) {'qrl://example.com/sqrl?nut=awnuts'}
  let(:session) {SQRL::ClientSession.new(url, imk)}
  let(:message) {<<RESPONSE}
ver=1\r
nut=#{nut}\r
tif=44\r
sfn=SQRL::Test\r
RESPONSE
  subject {SQRL::AuthenticationResponseParser.new(session, message)}

  it {expect(subject.post_path).to eq('http://example.com/sqrl?nut=awnuts')}
  it {expect(subject.params['ver']).to eq('1')}
  it {expect(subject.server_friendly_name).to eq('SQRL::Test')}
  it {expect(subject.ip_match?).to be_true}
  it {expect(subject.command_failed?).to be_true}
  it {expect(subject.logged_in?).to be_false}

  describe "encoded message" do
    let(:encoded) {"server=dmVyPTENCnRpZj02NA0KbnV0PU5XRXlZV1F4WlRFM056QTBOemhqTW1KbU5EUm1abVZrTUdZeVpqUmxOVFUNCnNmbj1UZXN0IFNlcnZlcg0K"}
    subject {SQRL::AuthenticationResponseParser.new(session, encoded)}

    it {expect(subject.params['ver']).to eq('1')}
    it {expect(subject.server_friendly_name).to eq('Test Server')}
    it {expect(subject.tif).to eq(0x64)}
    it {expect(subject.logged_in?).to be_false}
    it {expect(subject.command_failed?).to be_true}
  end
end
