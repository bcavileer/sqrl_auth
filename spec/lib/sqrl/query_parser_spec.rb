require 'spec_helper'
require 'sqrl/query_parser'
require 'sqrl/client_session'
require 'sqrl/query_generator'

describe SQRL::QueryParser do
  URL = 'sqrl://example.com/sqrl?nut=awnuts'
  def self.testcase
    session = SQRL::ClientSession.new(URL, 'x'*32)
    SQRL::QueryGenerator.new(session, URL).login!
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

  it {expect(SQRL::QueryParser.new({})).not_to be_valid}

  describe 'hash request' do
    subject {SQRL::QueryParser.new(request)}
    it {expect(subject.server_string).to eq(URL)}
    it {expect(subject.client_string).to match('ver=1\r\ncmd=login\r\nidk=')}
    it {expect(subject.client_data).to be_a(Hash)}
    it {expect(subject.client_data['ver']).to eq('1')}
    it {expect(subject.client_data['cmd']).to eq('login')}
    it {expect(subject.commands).to eq(['login'])}
    it {expect(subject.idk.length).to eq(32)}
    it {expect(subject.ids.length).to eq(64)}
    it {expect(subject).to be_valid}
  end

  describe 'string request' do
    subject {SQRL::QueryParser.new(body)}
    it {expect(subject.server_string).to eq(URL)}
    it {expect(subject.client_string).to match('ver=1\r\ncmd=login\r\nidk=')}
  end
end
