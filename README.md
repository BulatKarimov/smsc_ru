[![Gem Version](https://badge.fury.io/rb/smsc_ru.svg)](https://badge.fury.io/rb/smsc_ru)
[![Build Status](https://travis-ci.org/SPBTV/smsc_ru.svg?branch=master)](https://travis-ci.org/SPBTV/smsc_ru)
[![Test Coverage](https://codeclimate.com/github/SPBTV/smsc_ru/badges/coverage.svg)](https://codeclimate.com/github/SPBTV/smsc_ru/coverage)
[![Code Climate](https://codeclimate.com/github/SPBTV/smsc_ru/badges/gpa.svg)](https://codeclimate.com/github/SPBTV/smsc_ru)
[![Issue Count](https://codeclimate.com/github/SPBTV/smsc_ru/badges/issue_count.svg)](https://codeclimate.com/github/SPBTV/smsc_ru)

# Smsc_ru - Ruby API Client for smsc.ru

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smsc_ru'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smsc_ru

## Configuration

```ruby
Smsc.configure do |config|
 # Mandatory attributes, creating client fail, if it not specified
 config.login = 'your_login'
 config.password = 'your_password' # password or MD5 hash
  
 # Optional configuration
 # default: smsc.ru
 config.host = 'custom_endpoint'
 # default: false
 config.ssl = true
 # default Logger.new(STDOUT)
 config.logger = CustomerLogger.new
end
```

Or via constructor params:

```ruby
client = Smsc::Client.new do |client|
	client.login = 'custom loging'
	client.password = 'custom password'
end
```

## Usage

Usage example:
```ruby
 client = Smsc::Client.new
 
 # send one sms
 client.send_sms("79999999999", "Ваш пароль: 123")
 
 # send multiple sms
 client.send_sms("79999999999,78888888888", "Ваш пароль: 123")
 
  # raise error on problem
  client.send_sms("79999", "Ваш пароль: 123") # => error Smsc::BadRequest.new('invalid phone')
 
 # add additional parameters
 client.send_sms("79999999999,78888888888", "Ваш пароль: 123", translit: 1)
 
 # Check sms status
 client.status(12345, "79999999999") # => Smsc::Status model with attributes
 
 # Receive balance
 balance = client.balance
```

Gem wrap response in models and raise errors on problems

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
```
SMSC_LOGIN=your_login SMSC_PASSWORD=your_password bin/console
```
After starting console just type
```ruby
client = Smsc::Client.new
client.balance
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/SPBTV/smsc_ru )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

## License

Copyright 2015 SPB TV AG

Licensed under the Apache License, Version 2.0 (the ["License"](LICENSE)); you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License.

