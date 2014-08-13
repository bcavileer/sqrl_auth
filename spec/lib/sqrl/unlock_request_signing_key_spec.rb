require 'spec_helper'
require 'sqrl/unlock_request_signing_key'
require 'sqrl/random_lock_key'
require 'sqrl/identity_unlock_key'

describe SQRL::UnlockRequestSigningKey do
  let(:iuk) {SQRL::IdentityUnlockKey.new}
  let(:ilk) {iuk.identity_lock_key}
  let(:rlk) {SQRL::RandomLockKey.new}
  let(:vuk) {SQRL::VerifyUnlockKey.generate(ilk, rlk)}
  let(:vuk_reconstituted) {SQRL::VerifyUnlockKey.new(vuk.to_bytes)}
  let(:suk) {rlk.server_unlock_key}
  subject {SQRL::UnlockRequestSigningKey.new(suk, iuk)}

  it {expect(RbNaCl::SigningKey.new(subject).verify_key.to_s).to eq(vuk.to_bytes)}
  it {expect(subject.signature('string').bytesize).to eq(RbNaCl::Signatures::Ed25519::SIGNATUREBYTES)}
  it {expect(vuk_reconstituted.valid?(subject.signature('string'), 'string')).to be true}
end
