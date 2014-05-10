require 'proxy_manager/proxy'

module ProxyManager
  def self.root
    File.expand_path '../..', __FILE__
  end
end
