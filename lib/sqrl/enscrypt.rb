require 'scrypt'

module SQRL
  module EnScrypt
    extend self

    def scrypt(password, salt)
      # https://www.grc.com/sqrl/scrypt.htm
      SCrypt::Engine.scrypt(password, salt, 512, 256, 1, 32)
    end

    def hex(array)
      array.map {|c| "%0.2x" % c}.join('')
    end

    def encode_iterations(password, salt, iterations)
      password ||= ''
      salt ||= ''
      key = Array.new(32, 0)
      iterations.times do
        salt = scrypt(password, salt)
        32.times do |i|
          key[i] ^= salt[i].ord
        end
      end
      hex key
    end

    def encode_time(password, salt, limit)
      password ||= ''
      salt ||= ''
      key = Array.new(32, 0)
      iterations = 0
      start = Time.now
      while (iterations < 1 || Time.now - start < limit) do
        iterations += 1
        salt = scrypt(password, salt)
        32.times do |i|
          key[i] ^= salt[i].ord
        end
      end
      [hex(key), iterations]
    end
  end
end
