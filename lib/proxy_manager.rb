require 'proxy_manager/proxy'
require 'net/ping'

module ProxyManager
  # Define gem's root path
  # @return [String] string path
  def self.root
    File.expand_path '../..', __FILE__
  end
end
