require 'uri'

require 'uri/https'

module URI
  class SQRL < HTTPS
    DEFAULT_PORT = 443
  end
  @@schemes['SQRL'] = SQRL
end

module SQRL
  class URL < SimpleDelegator
    def self.parse(url)
      new URI.parse(url)
    end

    def initialize(domain_path, nut = nil)
      if (!nut)
        return super(domain_path)
      end

      parts = domain_path.split('/')
      host = parts.first
      parts[0] = ''
      super(URI::SQRL.build(:host => host, :path => parts.join('/'), :query => 'nut='+nut))
    end

    def nut
      query.split('&').find {|n| n.match('nut=')}.gsub('nut=', '')
    end
  end
end
