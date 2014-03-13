require 'rbnacl'

module SQRL
  class LoginRequest
    def initialize(params)
      if (params.respond_to?(:split))
        @params = Hash[params.split('&').map {|s| s.split('=')}]
      else
        @params = params
      end
      if @params.any? && !@params.keys.first.kind_of?(String)
        raise ArgumentError, "LoginRequest uses string keys for params"
      end
    end

    attr_reader :params

    def message
      params['client']+params['server']
    end

    def valid?
      return false unless client_data['idk']
      RbNaCl::VerifyKey.new(idk).verify(ids, message)
    # rbnacl raises in a slight breeze
    rescue StandardError => e
      p e
      false
    end

    def server_string
      decode(params['server'])
    end

    def client_string
      decode(params['client'])
    end

    def client_data
      Hash[client_string.split("\r\n").map {|s| s.split('=')}]
    end

    def idk
      decode(client_data['idk'])
    end

    def ids
      decode(params['ids'])
    end

    private
    def decode(s)
      return '' unless s
      r = (s.length % 4)
      badness = r > 0 ? 4 - r : 0
      Base64.urlsafe_decode64(s + '='*badness)
    end
  end
end
