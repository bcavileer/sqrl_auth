require 'sqrl/url'
require 'rbnacl'

module SQRL
  class SiteKey
    def initialize(imk, url)
      url = URL.parse(url) unless url.respond_to?(:signing_host)
      @private_key = RbNaCl::SigningKey.new(RbNaCl::HMAC::SHA256.auth(imk, url.signing_host))
      @public_key = @private_key.verify_key.to_s
    end

    attr_reader :public_key

    def signature(message)
      @private_key.sign(message)
    end
  end
end
