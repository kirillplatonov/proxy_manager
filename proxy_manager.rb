require "net/ping"

class ProxyManager
  attr_reader :proxy, :proxies

  def initialize(input = "proxies.txt")
    import_from input
    get_proxy
  end

  def connectable?(proxy)
    return Net::Ping::TCP.new(proxy[0], proxy[1]).ping
  end

  private

    def import_from(input)
      @proxies = Array.new
      source = input.is_a?(Array) ? input : File.open(input, "r")

      source.each do |line|
        proxy = line.split(":")
        @proxies << [proxy[0],proxy[1]]
      end
    end

    def get_proxy
      @proxies.each_with_index do |proxy, key|
        if connectable? proxy
          @proxy = proxy
          @proxies.delete_at(key)
          @proxies << @proxy
        end
      end
    end
end