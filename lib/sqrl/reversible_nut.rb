require 'openssl'

module SQRL
  class ReversibleNut
    @@serial = 0

    def initialize(server_key, ip, timestamp = Time.now.tv_sec, serial = @@serial)
      @server_key = server_key
      @ip = ip
      @timestamp = timestamp
      @serial = serial

      @@serial += 1
    end

    def self.reverse(server_key, bytes)
      raw = decrypt(server_key, bytes)
      up = raw.unpack('C4LLa4')
      ip = up[0..3].join('.')
      timestamp = up[4]
      serial = up[5]

      new(server_key, ip, timestamp, serial)
    end

    def to_bytes
      self.class.encrypt(server_key, raw_bytes)
    end
    alias_method :to_s, :to_bytes
    alias_method :to_s, :to_bytes

    def raw_bytes
      (ip.split('.').map(&:to_i) + [timestamp, serial, nonce]).pack('C4LLa4')
    end

    def self.encrypt(server_key, bytes)
      cipher = OpenSSL::Cipher::AES128.new(:CTR)
      cipher.encrypt
      cipher.key = server_key
      cipher.update(bytes)
    end

    def self.decrypt(server_key, bytes)
      cipher = OpenSSL::Cipher::AES128.new(:CTR)
      cipher.decrypt
      cipher.key = server_key
      cipher.update(bytes)
    end

    def nonce
      @nonce ||= SecureRandom.random_bytes(4)
    end

    attr_reader :server_key
    attr_accessor :ip
    attr_accessor :serial
    attr_accessor :timestamp
  end
end
