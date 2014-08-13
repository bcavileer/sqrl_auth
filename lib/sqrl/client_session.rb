require 'sqrl/key/site'
require 'sqrl/url'

module SQRL
  class ClientSession
    def initialize(url, imk)
      url = URL.parse(url)
      @post_path = url.post_path
      @site_key = Key::Site.new(imk, url.signing_host)
    end

    attr_accessor :post_path
    attr_reader :site_key
  end
end
