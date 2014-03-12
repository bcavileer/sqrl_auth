require 'spec_helper'
require 'sqrl/authentication_query'

describe SQRL::AuthenticationQuery do
  let(:url) {'https://example.com/sqrl?nut=awnuts'}
  let(:imk) {'x'*32}
  subject {SQRL::AuthenticationQuery.new(url, imk)}

  it {expect(subject.server_string).to eq(url)}
  it {expect(subject.client_string).to match("ver=1\r\ncmd=login\r\nidk=")}
  it {expect(subject.to_hash).to be_a(Hash)}
  it {expect(subject.to_hash[:server]).to eq('aHR0cHM6Ly9leGFtcGxlLmNvbS9zcXJsP251dD1hd251dHM')}
  it {expect(subject.to_hash[:client]).to match(/\A[\-\w_]+\Z/)}
  it {expect(subject.to_hash[:ids]).to match(/\A[\-\w_]+\Z/)}
  it {expect(subject.to_hash.keys).to eq([:client, :server, :ids])}
  it {expect(subject.post_body).to be_a(String)}
end
