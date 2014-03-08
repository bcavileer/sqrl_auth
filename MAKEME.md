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

### sqrl_auth

Though it's unlikly that Ruby will be on both sides of the conversation, it will server as a useful illustration.

Server: To create a SQRL login session, create a Nut

    server_key = SQRL::ServerKey.new

    nut = SQRL::ReversibleNut.new(sever_key, client_ip)
    url = SQRL::URL.new('example.com/sqrl', nut) # convience and testing
    url = sqrl_url(:nut => nut.to_s) # or use your framework
    qr_code(url)

Server sessions:

    nut = SQRL::OpaqueNut.new
    url = SQRL::URL.new('example.com', nut)
    session[:nut] = nut.to_s

Client: Once the code or link has been decoded

    # (obtain and decrypt the identity_master_key)

    url = SQRL::URL.load(surl)

    site_key = SQLR::SiteKey(identity_master_key, url)
    request = site_key.sign(url)
    # or
    request = identity_master_key.sign(surl)

    identity_master_key.wipe! # ????

    https_post(request.url, request.body)

Server: The server receives a request and verifies it

    req = SQRL::LoginRequest.new(request.body, server_key)
    raise unless req.valid?
    user = find_user(req.idk)
    response = req.respond_with(user) # if your user is protocol compatible
    send_response(response.body)
    login(req.client_ip, user) if req.login?

Server Sessions:

    req = SQRL::LoginRequest.new(request.body)
    login(find_session(req.nut), user)

Client: The client may inspect the response

    res = SQRL::LoginResponse(response.body)
    raise if res.failed?
    res.logged_in?
    res.server_friendly_name

### sqrl_client

    iuk = SQRL::IdentityUnlockKey.generate(large_quantity_of_random_noise)

    storage = SQRL::SSF.new(
      :identity_unlock_key => iuk,
      :rescue_code => rescue_code,
      :identity_master_key => iuk.identity_master_key,
      :password => password)
    File.open('filename.sqrl', 'w') {|f| f.write(storage.serialize)}


    contents = File.read('filename.sqrl')
    storage = SQRL::SSF.deserialize(contents, :password => password)
    storage = SQRL::SSF.deserialize(contents, :password => password)
    storage.encrypted_key
    id = SQRL::Hole.new(password, salt).dig(factor, count).dig_up(encrypted_key, tag)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
