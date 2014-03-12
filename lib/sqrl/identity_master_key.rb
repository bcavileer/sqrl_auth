module SQRL
  class IdentityMasterKey
    def initialize(bytes)
      @bytes = bytes
    end

    def to_bytes
      @bytes
    end
    alias_method :to_s, :to_bytes
    alias_method :to_str, :to_bytes

    def wipe!
      @bytes.length.times do |i| @bytes[i] = "\0" end
    end
  end
end
