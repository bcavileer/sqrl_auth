require 'base64'

module SQRL
  class LoginResponse
    def initialize(nut, flags, fields)
      @nut = nut
      @flags = flags
      @fields = fields
    end

    def response_body
      to_hash.to_a.map{|pair| pair.join('=')}.join('&')
    end

    def to_hash
      {
        :server => encode(server_string),
      }
    end

    def server_string
      server_data.to_a.map{|pair| pair.join('=')}.join("\r\n")
    end

    def server_data
      {
        :ver => '1',
        :nut => @nut,
        :tif => tif.to_s(16),
      }.merge(@fields)
    end

    def tif
      {
        0x01 => :id_match,
        0x02 => :previous_id_match,
        0x04 => :ip_match,
        0x08 => :login_enabled,
        0x10 => :logged_in,
        0x20 => :creation_allowed,
        0x40 => :command_failed,
        0x80 => :sqrl_failure,
      }.map {|bit, prop| @flags[prop] ? bit : 0}.reduce(0, &:|)
    end

    private

    def encode(string)
      Base64.urlsafe_encode64(string).sub(/=*\z/, '')
    end
  end
end
