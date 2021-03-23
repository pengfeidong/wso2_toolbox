# Wso2Toolbox

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/wso2_toolbox`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wso2_toolbox'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wso2_toolbox

## Usage

Firstly, need set credentials to generate token. Create `config/initializers/wso2_toolbox.rb` file and
fill in the attributes:
```
Wso2Toolbox.configure do |config|
  config.token_url = ENV['GENERATE_TOKEN_DEV_URL']
  config.token_username = ENV['GENERATE_TOKEN_DEV_USERNAME']
  config.token_password = ENV['GENERATE_TOKEN_DEV_PASSWORD']
end

Then, you can generate a token calling `Wso2Toolbox::TokenManager.generate_token`,
that it will set the new token in your request.

```
### Example controller

```
class MyController
  include Wso2Toolbox::IdentityHeaders
end
```

### Example test

In `spec_helper.rb` require 'paper_trail/frameworks/rspec'.

```
require 'rails_helper'

RSpec.describe MyController do
  it_behaves_like 'audit user', ApplicationController
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on Bitbucker at https://bitbucket.org/guideinvestimentos/wso2_toolboxÎ.
