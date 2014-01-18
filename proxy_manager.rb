require "net/ping"

class ProxyManager
  attr_reader :proxy, :proxies

  def initialize(proxies = "proxies.txt", bad_proxies = "bad_proxies.txt")
    @proxies = Array.new
    @bad_proxies = Array.new

    import_from proxies
    get_proxy
    save_proxies_sources "proxies", "bad_proxies"
  end

  def connectable?(proxy)
    return Net::Ping::TCP.new(proxy[0], proxy[1]).ping
  end

  private

    def import_from(proxies)
      File.open(proxies, "r").each do |line|
        proxy = line.chomp.split(":")
        @proxies << [proxy[0],proxy[1]] if proxy[0].kind_of?(String) && proxy[1].kind_of?(String)
      end
    end

    def get_proxy
      @proxies.each_with_index do |proxy, key|
        @proxies.delete_at(key)

        if connectable? proxy
          @proxy = proxy
          @proxies << proxy
          break
        else
          # move proxy to bad list
          @bad_proxies << proxy
        end
      end
    end

    def save_proxies_sources(*args)
      args.each do |arg|
        File.open("#{arg}.txt", "w+") do |f|
          @content = String.new

          instance_variable_get(("@" + arg).intern).each do |proxy|
            @content << "#{proxy[0]}:#{proxy[1]}\n" if !proxy.empty?
          end

          f.write(@content)
        end
      end
    end
end