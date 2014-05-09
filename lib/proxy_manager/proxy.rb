module ProxyManager
  class Proxy
    attr_reader :list

    def initialize(proxies)
      @list = []

      if proxies.is_a? Array
        load_list_from_array(proxies)
      else
        @list_file = proxies
        @list = load_from_file(@list_file)
      end
    end

    def get(count = 1)
      raise 'List is empty' if @list.empty?

      items = []
      new_list = @list.clone

      @list.each_with_index do |proxy, key|
        new_list.shift
        new_list << proxy

        if count == 1
          items = proxy
          break
        else
          items << proxy
          break if items.size == count
        end
      end

      @list = new_list

      raise 'There are no available proxy' if items.empty?

      save_to_file(@list_file, @list) if @list_file

      items
    end

    def get!(count = 1)
      raise 'List is empty' if @list.empty?

      items = []
      new_list = @list.clone

      @list.each_with_index do |proxy, key|
        new_list.shift

        if self.class.connectable? proxy
          new_list << proxy

          if count == 1
            items = proxy
            break
          else
            items << proxy
            break if items.size == count
          end
        end
      end

      @list = new_list

      raise 'There are no available proxy' if items.empty?

      save_to_file(@list_file, @list) if @list_file

      items
    end

    def self.connectable?(proxy)
      proxy = proxy.chomp.split(':') if proxy.is_a? String
      ip, port = proxy
      connection = Net::HTTP.new("http://google.com", nil, ip, port)
      connection.open_timeout = 3
      connection.read_timeout = 3

      connection.start do |http|
        return true if http.get('/')
      end

      false
    rescue Exception => e
      false
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
      list.each { |p| source << "#{p[0]}:#{p[1]}\n" }

      IO.write(file, source.sub(/\n$/, ''))
    end
  end
end
