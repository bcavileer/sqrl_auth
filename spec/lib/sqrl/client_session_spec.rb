require 'spec_helper'
require 'sqrl/client_session'
require 'sqrl/identity_master_key'

describe SQRL::ClientSession do
  let(:url) {'sqrl://example.com/sqrl?nut=awnuts'}
  let(:imk) {SQRL::IdentityMasterKey.new('x'.b*32)}
  subject {SQRL::ClientSession.new(url, imk)}

  it {expect(subject.post_path).to eq('https://example.com/sqrl?nut=awnuts')}
  it {expect(subject.site_key).to be_a(SQRL::SiteKey)}
end
