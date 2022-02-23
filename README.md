# Sendgrid::Object

This gem provide classes for an easy use of the [sendrig-ruby](https://github.com/sendgrid/sendgrid-ruby) official gem.

## Prerequisites

Ruby version >= 2.4 (except version [2.6.0](https://github.com/sendgrid/sendgrid-ruby/blob/main/TROUBLESHOOTING.md#ruby-versions))

## Setup Environment Variables

Update the development environment with your SENDGRID_API_KEY, for example:

```
echo "export SENDGRID_API_KEY='YOUR_API_KEY'" > sendgrid.env
echo "sendgrid.env" >> .gitignore
source ./sendgrid.env
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sendgrid-object'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sendgrid-object

## Quick start

TODO write some examples

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/immateriel/sendgrid-object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sendgrid-object/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sendgrid::Object project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sendgrid-object/blob/master/CODE_OF_CONDUCT.md).
