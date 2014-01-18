class ProxyManager
  def initialize(input = "proxies.txt")
    import_from input
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
end