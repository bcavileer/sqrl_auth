require 'openssl'
require 'sqrl/base64'

module SQRL
  class ReversibleNut
    @@serial = 0

    def initialize(server_key, ip, timestamp = now, serial = @@serial)
      @server_key = server_key
      @ip = ip
      @timestamp = timestamp
      @serial = serial

      @@serial += 1
    end

    def self.reverse(server_key, nut)
      bytes = Base64.decode(nut)
      raw = decrypt(server_key, bytes)
      up = raw.unpack('C4LLa4')
      ip = up[0..3].join('.')
      timestamp = up[4]
      serial = up[5]

      new(server_key, ip, timestamp, serial)
    end

    def b
      self.class.encrypt(server_key, raw_bytes)
    end

    def to_s
      Base64.encode(b)
    end

    alias_method :to_str, :to_s

    def response_nut
      self.class.new(server_key, ip)
    end

    def raw_bytes
      (ip.split('.').map(&:to_i) + [timestamp, serial, nonce]).pack('C4LLa4')
    end

    def self.new_cipher
      OpenSSL::Cipher::AES128.new(:CFB)
    end

    def self.encrypt(server_key, bytes)
      cipher = new_cipher
      cipher.encrypt
      cipher.key = server_key.b
      cipher.update(bytes)
    end

    def self.decrypt(server_key, bytes)
      cipher = new_cipher
      cipher.decrypt
      cipher.key = server_key.b
      cipher.update(bytes)
    end

    def nonce
      @nonce ||= SecureRandom.random_bytes(4)
    end

    def age
      now - timestamp
    end

    attr_reader :server_key
    attr_accessor :ip
    attr_accessor :serial
    attr_accessor :timestamp

    private

    def now
      Time.now.tv_sec
    end
  end
end
