module SQRL
  class OpaqueNut
    def to_s
      SecureRandom.urlsafe_base64(20, false)
    end

    alias_method :to_string, :to_s
  end
end
