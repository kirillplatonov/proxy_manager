# Ruby Proxy Manager

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
proxy = ProxyManager.load(['1.2.3.4:567', '9.8.7.6:543'])
```

or from file

```ruby
proxy = ProxyManager.load('proxies.txt', 'bad_proxies.txt')
```

Files `proxies.txt` and `bad_proxies.txt` should be writable.
Example of `proxies.txt` content:

```
1.2.3.4:567
9.8.7.6:543
...
```

### Get proxy

Get one proxy

```ruby
proxy.get
# => ["1.2.3.4", 567]
```

Get many proxies

```ruby
proxy.get(2)
# => [["1.2.3.4", 567], ["9.8.7.6", 543]]
```

Will be returning only pingable proxies

### Proxies lists

You also can display list of loaded proxies

```ruby
proxy.list
# => [["1.2.3.4", 567], ["9.8.7.6", 543]]
```

and list of bad proxies

```ruby
proxy.bad_list
# => []
```

## Documentation

http://rubydoc.info/gems/proxy_manager/frames

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
