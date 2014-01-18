require "net/ping"

class ProxyManager
  attr_reader :proxy, :proxies

  def initialize(input = "proxies.txt")
    import_from input
    get_proxy
    save_proxies_source input
  end

  def connectable?(proxy)
    return Net::Ping::TCP.new(proxy[0], proxy[1]).ping
  end

  private

    def import_from(input)
      @proxies = Array.new

      File.open(input, "r").each do |line|
        proxy = line.chomp.split(":")
        @proxies << [proxy[0],proxy[1]] if proxy[0].kind_of?(String) && proxy[1].kind_of?(String)
      end
    end

    def get_proxy
      @proxies.each_with_index do |proxy, key|
        if connectable? proxy
          @proxy = proxy
          @proxies.delete_at(key)
          @proxies << @proxy
          break
        end
      end
    end

    def save_proxies_source(input)
      File.open(input, "w+") do |f|
        @content = String.new

        @proxies.each do |proxy|
          @content << "#{proxy[0]}:#{proxy[1]}\n" if !proxy.empty?
        end

        f.write(@content)
      end
    end
end