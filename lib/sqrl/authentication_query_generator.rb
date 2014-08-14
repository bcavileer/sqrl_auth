require 'sqrl/base64'

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
    attr_reader :server_unlock_key
    attr_reader :verify_unlock_key

    def setkey! # idk assumed in a valid request
      @commands << 'setkey'
      self
    end

    def setlock!(options)
      if !(options[:suk] && options[:vuk])
        raise ArgumentError, ":suk and :vuk are required to setlock"
      end
      @commands << 'setlock'
      @server_unlock_key = encode(options[:suk])
      @verify_unlock_key = encode(options[:vuk])
      self
    end

    def create!
      @commands << 'create'
      self
    end

    def login!
      @commands << 'login'
      self
    end

    def logout!
      @commands << 'logout'
      self
    end

    # depreciated
    def logoff!
      @commands << 'logoff'
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
        :suk => @server_unlock_key,
        :vuk => @verify_unlock_key,
      }.reject {|k,v| v.nil? || v == ''}
    end

    private

    def site_key
      @session.site_key
    end

    def encode(string)
      Base64.encode(string)
    end
  end
end
