require 'base64'

module SQRL
  class AuthenticationQueryGenerator
    def initialize(session, server_string)
      @session = session
      @server_string = server_string
      @commands = []
    end

    attr_reader :session
    attr_reader :server_string
    attr_reader :commands

    def login!
      @commands << 'login'
      self
    end

    def post_path
      @session.post_path
    end

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

    def client_data
      {
        :ver => 1,
        :cmd => @commands.join('~'),
        :idk => encode(site_key.public_key),
      }
    end

    private

    def site_key
      @session.site_key
    end

    def encode(string)
      Base64.urlsafe_encode64(string).sub(/=*\z/, '')
    end
  end
end
