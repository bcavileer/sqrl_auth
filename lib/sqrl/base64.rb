require 'base64'

module SQRL
  module Base64
    extend self

    def encode(s)
      return '' unless s
      ::Base64.urlsafe_encode64(s).sub(/=*\z/, '')
    end

    def decode(s)
      return '' unless s
      r = (s.length % 4)
      badness = r > 0 ? 4 - r : 0
      ::Base64.urlsafe_decode64(s + '='*badness)
    end
  end
end
