module ProxyManager
  class ProxyManager
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

        load_list_from_file(proxies)
      end
    end

    def connectable?(proxy)
      proxy = proxy.chomp.split(':') if proxy.is_a? String
      Net::Ping::TCP.new(proxy[0], proxy[1].to_i).ping
    end

    def get(count = 1)
      raise 'List is empty' if @list.empty?

      items = []

      @list.each_with_index do |proxy, key|
        @list.delete_at(key)

        if connectable? proxy
          @list << proxy

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

      raise 'There are no available proxy' if items.empty?
      
      if @list_file && @bad_list_file
        File.open(@list_file, "w+") do |f|
          source = ''

          @list.each_with_index do |p, index|
            source << "#{p[0]}:#{p[1]}"
            source << "\n" if @list[index + 1]
          end

          f.write(source)
        end

        File.open(@bad_list_file, "w+") do |f|
          source = ''

          @bad_list.each_with_index do |p, index|
            source << "#{p[0]}:#{p[1]}"
            source << "\n" if @bad_list[index + 1]
          end

          f.write(source)
        end
      end

      items
    end

    private

      def load_list_from_array(proxies)
        @list = proxies.map { |arg| [arg.split(':')[0], arg.split(':')[1].to_i] }
      end

      def load_list_from_file(proxies)
        File.open(proxies, "r").each do |line|     
          line = line.chomp.split(':')
          if line[0].is_a? String and line[1].is_a? String
            @list << [line[0], line[1].to_i]
          end
        end
      end
  end
end