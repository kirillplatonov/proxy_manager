class ProxyManager
  attr_reader :proxy, :proxies

  def initialize(input = "proxies.txt")
    import_from input
    get_proxy
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
      @proxy = @proxies[0]
      # move first element to the end
      @proxies.delete_at(0)
      @proxies << @proxy
    end
end