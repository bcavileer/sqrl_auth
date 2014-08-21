require 'rbnacl'

module SQRL
  module EnHash
    extend self

    def sha256(key)
      RbNaCl::Hash.sha256(key)
    end

    def call(key, iterations = 16)
      key ||= ''
      out = Array.new(32, 0)
      iterations.times do
        key = sha256(key)
        32.times do |i|
          out[i] ^= key[i].ord
        end
      end
      out.pack('C32')
    end
  end
end
