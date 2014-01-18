# Ruby Proxy Manager
This is the class for easy usage proxy in parser/web bots. It will help you to save your proxies from block and will check proxy availability for you.
For use it needs to create a list of proxies in IP:PORT format and pass it to ProxyManager.
### Usage
```ruby
manager = ProxyManager.new "proxies.txt"

# Get proxy for usage
manager.proxy
# => ["192.227.139.227", "3127"]

# Get list of available proxies
manager.proxies
# => [["41.33.182.198", "8080"], ["62.68.99.140", "3030"], ["192.227.139.227", "3127"]]

# Get list with non pinging proxies
manager.bad_proxies
# => []
```