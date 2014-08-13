require 'sqrl/base64'
require 'sqrl/key/site'
require 'sqrl/url'
require 'sqrl/tif'

module SQRL
  class AuthenticationResponseParser
    def initialize(session, params)
      @session = session

      if (params.respond_to?(:split))
        @params = parse_params(params)
      else
        @params = params
      end

      if @params.any? && !@params.keys.first.kind_of?(String)
        raise ArgumentError, "#{self.class.name} uses string keys for params"
      end

      if @params['server']
        @params = parse_params(decode(@params['server']))
      end
    end

    attr_reader :params
    attr_reader :session

    def post_path
      session.post_path
    end

    def server_friendly_name
      params['sfn'] || 'unspecified'
    end

    def tif
      (params['tif'] || '').to_i(16)
    end

    TIF.each do |bit,prop|
      define_method(prop.to_s+'?') do
        tif & bit != 0
      end
    end

    def suk?
      params['suk']
    end

    def suk
      decode(params['suk'])
    end

    private

    def decode(s)
      Base64.decode(s)
    end

    def parse_params(s)
      Hash[s.split("\r\n").map {|s| s.split('=')}]
    end
  end
end
