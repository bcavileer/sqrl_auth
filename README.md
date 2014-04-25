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

    server_key = SQRL::ServerKey.new

    nut = SQRL::ReversibleNut.new(server_key, client_ip)
    url = SQRL::URL.new('example.com/sqrl', nut) # convience and testing
    url = sqrl_url(:nut => nut.to_s) # or use your framework
    qr_code(url)

Server sessions:

    nut = SQRL::OpaqueNut.new
    session[:nut] = nut.to_s

Client: Once the code or link has been decoded

    # (obtain and decrypt the identity_master_key)

    request = SQRL::AuthenticationQuery.new(url, identity_master_key)
    # request.pidk =
    # request.suk =
    # request.iuk =

    https_post(request.url, request.to_hash)
    # or request.post_body depending on what your library wants

    identity_master_key.wipe!

Server: The server receives a request and verifies it

    req = SQRL::LoginRequest.new(request.body)
    invalid = !req.valid?
    req_nut = SQRL::ReversibleNut.reverse(server_key, params[:nut])
    user = find_user(req.idk)
    res_nut = req_nut.response_nut
    response = SQRL::LoginResponse.new(res_nut, {
      :id_match => req.idk == user.idk,
      :previous_id_match => req.pidk == user.idk,
      :ip_match => request.ip == req_nut.ip,
      :login_enabled => user.sqrl_enabled?,
      :logged_in => session.logged_in?(user),
      :command_failed => invalid,
      :sqrl_failure => invalid,
    }, {
      :sfn => 'CoolApp',
      :foo => 'bar',
    })
    send_response(response.response_body)
    login(req_nut.ip, user) if req.login?

Server Sessions:

    req = SQRL::LoginRequest.new(request.body)
    login(find_session(params[:nut]), user)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
