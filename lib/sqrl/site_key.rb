require 'sqrl/url'
require 'openssl'
require 'rbnacl'

module SQRL
  class SiteKey
    def initialize(imk, url)
      url = URL.parse(url) unless url.respond_to?(:host)
      @private_key = OpenSSL::HMAC.digest('sha256', imk, url.host)
      @public_key = RbNaCl::GroupElements::Curve25519.base.mult(@private_key).to_s
    end

    attr_reader :private_key
    attr_reader :public_key
  end
end
