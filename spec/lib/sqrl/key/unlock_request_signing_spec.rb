require 'spec_helper'
require 'sqrl/key/unlock_request_signing'
require 'sqrl/key/random_lock'
require 'sqrl/key/identity_unlock'

describe SQRL::Key::UnlockRequestSigning do
  let(:iuk) {SQRL::Key::IdentityUnlock.new}
  let(:ilk) {iuk.identity_lock_key}
  let(:rlk) {SQRL::Key::RandomLock.new}
  let(:vuk) {SQRL::Key::VerifyUnlock.generate(ilk, rlk)}
  let(:vuk_reconstituted) {SQRL::Key::VerifyUnlock.new(vuk.to_bytes)}
  let(:suk) {rlk.server_unlock_key}
  subject {SQRL::Key::UnlockRequestSigning.new(suk, iuk)}

  it {expect(RbNaCl::SigningKey.new(subject).verify_key.to_s).to eq(vuk.to_bytes)}
  it {expect(subject.signature('string').bytesize).to eq(RbNaCl::Signatures::Ed25519::SIGNATUREBYTES)}
  it {expect(vuk_reconstituted.valid?(subject.signature('string'), 'string')).to be true}
end
