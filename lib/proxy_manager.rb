require 'proxy_manager/main'
require 'net/ping'

module ProxyManager
  # Define gem's root path
  # @return [String] string path
  def self.root
    File.expand_path '../..', __FILE__
  end

  # Create main object
  # @param proxies [Array, String] array of proxies or file with proxies
  # @param bad_proxies [String, nil] optional file for save bad proxies
  # @example
  #   # from array
  #   proxy = ProxyManager.load(['1.2.3.4:567', '9.8.7.6:543'])
  #
  #   # or from file
  #   proxy = ProxyManager.load('proxies.txt', 'bad_proxies.txt')
  # @return [Class] Main object
  # @see Main
  def self.load(proxies, bad_proxies = nil)
    Main.new(proxies, bad_proxies)
  end
end
