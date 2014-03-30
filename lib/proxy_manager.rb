require 'proxy_manager/main'
require 'net/ping'

module ProxyManager
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.load(proxies, bad_proxies = nil)
    Main.new(proxies, bad_proxies)
  end
end
