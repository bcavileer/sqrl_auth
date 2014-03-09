# Sqrl::Auth

A Ruby implementation of core SQRL alorithims used when challenging, signing, and verifying SQRL authentication requests

For a gentle introduction to SQRL, try http://sqrl.pl  For All the gritty technical detail, https://www.grc.com/sqrl/sqrl.htm

## Installation

Add this line to your application's Gemfile:

    gem 'sqrl_auth'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sqrl_auth

## Usage

Though it's unlikely that Ruby will be on both sides of the conversation, it will server as a useful illustration.

Server: To create a SQRL login session, create a Nut

    url = SQRL::URL.new('example.com/sqrl', nut) # convience and testing
    url = sqrl_url(:nut => nut.to_s) # or use your framework
    qr_code(url)

Server sessions:

    nut = SQRL::OpaqueNut.new
    session[:nut] = nut.to_s

Client: Once the code or link has been decoded

    # (obtain and decrypt the identity_master_key)

    url = SQRL::URL.parse(surl)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
