module ProxyManager
  class Main
    attr_reader :list, :bad_list, :list_file, :bad_list_file

    def initialize(proxies, bad_proxies)
      @list = []
      @bad_list = []

      if proxies.is_a? Array
        load_list_from_array(proxies)
      else
        if proxies.empty? or bad_proxies.empty?
          raise 'Both arguments "proxies" and "bad_proxies" required'
        end

        @list_file, @bad_list_file = proxies, bad_proxies

        @list = load_from_file(@list_file)
        @bad_list = load_from_file(@bad_list_file)
      end
    end

    def connectable?(proxy)
      proxy = proxy.chomp.split(':') if proxy.is_a? String
      Net::Ping::TCP.new(proxy[0], proxy[1].to_i).ping
    end

    def get(count = 1)
      raise 'List is empty' if @list.empty?

      items = []
      new_list = @list.clone

      @list.each_with_index do |proxy, key|
        new_list.shift

        if connectable? proxy
          new_list << proxy

          if count == 1
            items = proxy
            break
          else
            items << proxy
            break if items.size == count
          end
        else
          @bad_list << proxy
        end
      end

      @list = new_list

      raise 'There are no available proxy' if items.empty?

      if @list_file && @bad_list_file
        save_to_file(@list_file, @list)
        save_to_file(@bad_list_file, @bad_list)
      end

      items
    end

    private

    def load_list_from_array(proxies)
      @list = proxies.map { |arg| [arg.split(':')[0], arg.split(':')[1].to_i] }
    end

    def load_from_file(file)
      result = []
      IO.readlines(file).each do |line|
        ip, port = line.chomp.split(':')
        result << [ip, port.to_i] if ip.is_a?(String) && port.is_a?(String)
      end
      result
    end

    def save_to_file(file, list)
      source = ''
      list.each { |p| source << "#{p[0]}:#{p[1]}" }

      IO.write(file, source.sub(/\\n$/, ''))
    end
  end
end
