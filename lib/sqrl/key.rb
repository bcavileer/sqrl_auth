require 'sqrl/base64'

module SQRL
  class Key
    def initialize(bytes)
      bytes = bytes.b
      unless bytes.length == key_length
        raise ArgumentError, "keys must be 32 bytes #{bytes.length})"
      end
      @bytes = bytes
    end

    def key_length; 32; end

    def b
      @bytes
    end

    def to_s
      Base64.encode(@bytes)
    end

    def wipe!
      @bytes.length.times do |i| @bytes[i] = "\0" end
    end
  end
end
