[![Ruby](https://github.com/nvoynov/cleon-users/actions/workflows/main.yml/badge.svg)](https://github.com/nvoynov/cleon-users/actions/workflows/main.yml)

# Users

The `Users` gem serves for simple but clean users domain model (bounded context) presented in the first chapter of the "Service-Oriented Design with Ruby and Rails (2010)."

The word "clean" there stands for [The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html). So it is just domain model that provides entities, interactors and gateways interface. "Clean" skeleton of the domain model was created by using [Cleon](https://github.com/nvoynov/cleon).

To turn this model into a useful application, all you need to add to this model is the actual implementation of the gateway and the user interface. And this part will be provided later in a shape of users REST service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'users'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install users

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/users.
