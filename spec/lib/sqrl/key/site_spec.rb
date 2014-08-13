require 'spec_helper'
require 'sqrl/key/site'

describe SQRL::Key::Site do
  let(:imk) {'x'.b*32}
  let(:host) {'example.com'}
  subject {SQRL::Key::Site.new(imk, host)}

  it {expect(subject.public_key).to be_a(String)}
  it {expect(subject.signature('string').bytesize).to eq(RbNaCl::Signatures::Ed25519::SIGNATUREBYTES)}
  it {expect(subject.signature('string')).to eq("]m\x9F@\xE9^\xB9\rR\xD4\x9F\x97-\xC6\x892\x8F\x9A\xA7U<\xB0\xEE\x17\xDD+\xA3\x8Cx\x10\x97\b\x93\xAA\x1F\x96\xB4\x9F\\\xBC/fh8\xCE\xE9\xD8_\x16\xF8\xB3#\xA3\t\x87K\xE2g\b\x9C\xC7\xA9\xC5\r")}
end
