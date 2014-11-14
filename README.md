# Ruby Proxy Manager

[![Gem Version](https://badge.fury.io/rb/proxy_manager.svg)](http://badge.fury.io/rb/proxy_manager)
[![Build Status](https://travis-ci.org/kirillplatonov/proxy_manager.svg?branch=master)](https://travis-ci.org/kirillplatonov/proxy_manager)
[![Code Climate](https://codeclimate.com/github/kirillplatonov/proxy_manager.png)](https://codeclimate.com/github/kirillplatonov/proxy_manager)
[![Coverage](https://codeclimate.com/github/kirillplatonov/proxy_manager/coverage.png)](https://codeclimate.com/github/kirillplatonov/proxy_manager)

Easy manage proxy in your parsers/web-bots.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'proxy_manager'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install proxy_manager
```

## Usage

### Load proxy list

From array (IP:PORT)

```ruby
proxy = ProxyManager::Proxy.new(['127.0.0.1:80', '127.0.0.1:8080'])
```

or from file

```ruby
proxy = ProxyManager::Proxy.new('proxies.txt')
```

File with proxy list (in this case `proxies.txt`) should be readable and
writable.
Example of `proxies.txt` content:

```
127.0.0.1:80
127.0.0.1:8080
...
```

### Get proxy

There is two methods to get proxy.

First method return just next proxy, without any checking for availability:

```ruby
proxy.get
# => ["127.0.0.1", 80]
```

Band method return **only HTTP-available proxy**. It's perfect if you don't
realy confidency on actuallity of your proxy list:

```ruby
proxy.get!
# => ["127.0.0.1", 8080]
```

You can also get for than one proxy per request by adding count for both
methods like this:

```ruby
proxy.get(2)
# => [["127.0.0.1", 80], ["127.0.0.1", 8080]]

proxy.get!(2)
# => [["127.0.0.1", 80], ["127.0.0.1", 8080]]
```

### Proxies list

For display list of loaded proxies use `list` method:

```ruby
proxy.list
# => [["127.0.0.1", 80], ["127.0.0.1", 8080]]
```

### Checking proxy manually

You can also use class method for checking availability manually like this:

```ruby
# by passing a string
ProxyManager::Proxy.connectable?('127.0.0.1:80')
# => false

# or by passing an array
ProxyManager::Proxy.connectable?('127.0.0.1', 80)
# => false
```

Please, don't forget to star :star: the repository if you like (and use) the library. This will let me know how many users it has and then how to proceed with further development :).

## Documentation

http://rubydoc.info/gems/proxy_manager

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
