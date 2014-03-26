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
      new parser.parse(url)
    end

    def self.parser
      URI::Parser.new(:UNRESERVED => "|\\-_.!~*'()a-zA-Z\\d")
    end

    def initialize(domain_path, nut = nil)
      if (!nut)
        return super(domain_path)
      end

      parts = domain_path.split('/')
      host = parts.first
      parts[0] = ''
      path = parts.join('/')
      query = 'nut='+nut
      super(URI::SQRL.new('sqrl', nil, host, nil, nil, path, nil, query, nil, self.class.parser))
    end

    def nut
      query.split('&').find {|n| n.match('nut=')}.gsub('nut=', '')
    end

    def signing_host
      parts = path.split('|')
      if (parts.length > 1)
        host + parts.first
      else
        host
      end
    end

    def post_path
      to_s.sub('|', '/')
    end
  end
end
