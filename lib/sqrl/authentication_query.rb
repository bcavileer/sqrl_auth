require 'base64'
require 'delegate'
require 'sqrl/site_key'
require 'sqrl/url'

module SQRL
  class AuthenticationQuery
    def initialize(url, imk)
      @url = url
      @site_key = SiteKey.new(imk, url)
    end

    def url
      URL.parse(@url).post_path
    end

    attr_reader :site_key

    def post_body
      to_hash.to_a.map{|pair| pair.join('=')}.join('&')
    end

    def to_hash
      client = encode(client_string)
      server = encode(server_string)
      base = client + server
      {
        :client => client,
        :server => server,
        :ids => encode(site_key.signature(base)),
      }
    end

    def client_string
      client_data.to_a.map{|pair| pair.join('=')}.join("\r\n")
    end

    def server_string
      @url
    end

    def client_data
      {
        :ver => 1,
        :cmd => 'login',
        :idk => encode(site_key.public_key),
      }
    end

    private

    def encode(string)
      Base64.urlsafe_encode64(string).sub(/=*\z/, '')
    end
  end
end
