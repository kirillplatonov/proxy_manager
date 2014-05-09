require 'proxy_manager/proxy'
require 'net/ping'

module ProxyManager
  def self.root
    File.expand_path '../..', __FILE__
  end
end
