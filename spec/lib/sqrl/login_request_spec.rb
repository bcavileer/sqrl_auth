require 'spec_helper'
require 'sqrl/login_request'
require 'sqrl/authentication_query'

describe SQRL::LoginRequest do
  URL = 'https://example.com/sqrl?nut=awnuts'
  def self.testcase
    SQRL::AuthenticationQuery.new(URL, 'x'*32)
  end
  #p testcase.to_hash
  #p testcase.post_body

  let(:raw_request) {
    {:client=>"dmVyPTENCmNtZD1sb2dpbg0KaWRrPXZkYW82Rk9Pdk05TElpN3JQUGNGSFI4bS1vZ2dTd0xTUW9QNUNUdVJzUU0", :server=>"aHR0cHM6Ly9leGFtcGxlLmNvbS9zcXJsP251dD1hd251dHM", :ids=>"qLUf90XVFW-VmkrV3yE6Ba6n7suQ8MriG7tkicsNbC0ULRwCFBYF2TLg5uxoEbpbLakw7Jgq7tZswvcLxKX5Bw"}
  }
  let(:request) {
    Hash[raw_request.map {|k,v| [k.to_s,v]}]
  }
  let(:body) {
    "client=dmVyPTENCmNtZD1sb2dpbg0KaWRrPXZkYW82Rk9Pdk05TElpN3JQUGNGSFI4bS1vZ2dTd0xTUW9QNUNUdVJzUU0&server=aHR0cHM6Ly9leGFtcGxlLmNvbS9zcXJsP251dD1hd251dHM&ids=qLUf90XVFW-VmkrV3yE6Ba6n7suQ8MriG7tkicsNbC0ULRwCFBYF2TLg5uxoEbpbLakw7Jgq7tZswvcLxKX5Bw"
  }

  it {expect(SQRL::LoginRequest.new({})).not_to be_valid}

  describe 'hash request' do
    subject {SQRL::LoginRequest.new(request)}
    it {expect(subject.server_string).to eq(URL)}
    it {expect(subject.client_string).to match('ver=1\r\ncmd=login\r\nidk=')}
    it {expect(subject.client_data).to be_a(Hash)}
    it {expect(subject.client_data['ver']).to eq('1')}
    it {expect(subject.idk.length).to eq(32)}
    it {expect(subject.ids.length).to eq(64)}
    it {expect(SQRL::LoginRequest.new(request)).to be_valid}
  end

  describe 'string request' do
    subject {SQRL::LoginRequest.new(body)}
    it {expect(subject.server_string).to eq(URL)}
    it {expect(subject.client_string).to match('ver=1\r\ncmd=login\r\nidk=')}
  end
end
