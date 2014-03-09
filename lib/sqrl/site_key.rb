require 'sqrl/url'
require 'openssl'

module SQRL
  class SiteKey
    def initialize(imk, url)
      url = URL.parse(url) unless url.respond_to?(:host)
      @private_key = OpenSSL::HMAC.digest('sha256', imk, url.host)
    end

    attr_reader :private_key
  end
end
