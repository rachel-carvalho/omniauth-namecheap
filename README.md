# Omniauth::Namecheap

[![Build Status](https://travis-ci.com/rachel-carvalho/omniauth-namecheap.svg?branch=master)](https://travis-ci.com/rachel-carvalho/omniauth-namecheap)

This is an Omniauth strategy for Namecheap.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-namecheap'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-namecheap

## Usage

To use it with [Devise](https://github.com/plataformatec/devise), provide the client id, secret and scope within Devise's config.

```ruby
config.omniauth :namecheap, ENV['NAMECHEAP_CLIENT_ID'], ENV['NAMECHEAP_SECRET'], scope: 'openid profile offline_access'
```

To use Namecheap's sandbox url, just override `client_options` / `site`:

```ruby
config.omniauth :namecheap, ENV['NAMECHEAP_CLIENT_ID'], ENV['NAMECHEAP_SECRET'], scope: 'openid profile offline_access', client_options: { site: 'https://www.sandbox.namecheap.com' }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rachel-carvalho/omniauth-namecheap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Namecheap project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rachel-carvalho/omniauth-namecheap/blob/master/CODE_OF_CONDUCT.md).
