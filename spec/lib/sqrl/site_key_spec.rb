require 'spec_helper'
require 'sqrl/site_key'

describe SQRL::SiteKey do
  let(:imk) {'x'*32}
  let(:host) {'example.com'}
  subject {SQRL::SiteKey.new(imk, host)}

  it {expect(subject.public_key).to be_a(String)}
  it {expect(subject.signature('string')).to be_a(String)}
end
