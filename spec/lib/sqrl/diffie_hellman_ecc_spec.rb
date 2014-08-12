require 'spec_helper'
require 'sqrl/diffie_hellman_ecc'

describe SQRL::DiffieHellmanECC do
  # test vectors from RbNaCl, from NaCl
  let(:alice_private) {["77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a"].pack('H*')}
  let(:alice_public)  {["8520f0098930a754748b7ddcb43ef75a0dbf3a0d26381af4eba4a98eaa9b4e6a"].pack('H*')}
  let(:bob_private) {["5dab087e624a8a4b79e17f8b83800ee66f3bb1292618b6fd1c2f8b27ff88e0eb"].pack('H*')}
  let(:bob_public) {["de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f"].pack('H*')}
  let(:alice_mult_bob) {["4a5d9d5ba4ce2de1728e3bf480350f25e07e21c947d19e3376f09b3c1e161742"].pack('H*')}

  it {expect(SQRL::DiffieHellmanECC.public_key(alice_private)).to eq(alice_public)}
  it {expect(SQRL::DiffieHellmanECC.shared_secret(bob_public, alice_private)).to eq(alice_mult_bob)}
  it {expect(SQRL::DiffieHellmanECC.shared_secret(alice_public, bob_private)).to eq(alice_mult_bob)}
end
