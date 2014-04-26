require 'spec_helper'
require 'sqrl/login_request'
require 'sqrl/authentication_query_generator'

describe SQRL::LoginRequest do
  URL = 'sqrl://example.com/sqrl?nut=awnuts'
  def self.testcase
    SQRL::AuthenticationQueryGenerator.new(URL, 'x'*32)
  end
  #p testcase.to_hash
  #p testcase.post_body

  let(:raw_request) {
    {:client=>"dmVyPTENCmNtZD1sb2dpbg0KaWRrPXZkYW82Rk9Pdk05TElpN3JQUGNGSFI4bS1vZ2dTd0xTUW9QNUNUdVJzUU0", :server=>"c3FybDovL2V4YW1wbGUuY29tL3Nxcmw_bnV0PWF3bnV0cw", :ids=>"QKKRM7ygMKilHrYLOp9X4ZndAYZ3nZaQVI8l-qVSIj7XUebqnG_GZ2jOTuZMOlNOVz36RyBCrC7wdvSJl6phAQ"}
  }
  let(:request) {
    Hash[raw_request.map {|k,v| [k.to_s,v]}]
  }
  let(:body) {
    "client=dmVyPTENCmNtZD1sb2dpbg0KaWRrPXZkYW82Rk9Pdk05TElpN3JQUGNGSFI4bS1vZ2dTd0xTUW9QNUNUdVJzUU0&server=c3FybDovL2V4YW1wbGUuY29tL3Nxcmw_bnV0PWF3bnV0cw&ids=QKKRM7ygMKilHrYLOp9X4ZndAYZ3nZaQVI8l-qVSIj7XUebqnG_GZ2jOTuZMOlNOVz36RyBCrC7wdvSJl6phAQ"
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
