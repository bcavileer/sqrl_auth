require 'base64'
require 'sqrl/site_key'
require 'sqrl/url'

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
      params['tif'].to_i(16)
    end

    TIF = {
      0x01 => :id_match,
      0x02 => :previous_id_match,
      0x04 => :ip_match,
      0x08 => :login_enabled,
      0x10 => :logged_in,
      0x20 => :creation_allowed,
      0x40 => :command_failed,
      0x80 => :sqrl_failure,
    }.each do |bit,prop|
      define_method(prop.to_s+'?') do
        tif & bit != 0
      end
    end

    private

    def decode(s)
      return '' unless s
      r = (s.length % 4)
      badness = r > 0 ? 4 - r : 0
      Base64.urlsafe_decode64(s + '='*badness)
    end

    def parse_params(s)
      Hash[s.split("\r\n").map {|s| s.split('=')}]
    end
  end
end