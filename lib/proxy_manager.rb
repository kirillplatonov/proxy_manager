require 'proxy_manager/proxy_manager'

module ProxyManager
  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.load(proxies, bad_proxies = nil)
    ProxyManager.new(proxies, bad_proxies)
  end
end
