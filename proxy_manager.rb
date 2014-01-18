class ProxyManager
  def initialize(input = "proxies.txt")
    @proxies = input.is_a?(Array) ? input : import_from_source(input)
  end
end