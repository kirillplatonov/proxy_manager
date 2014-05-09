require 'spec_helper'
require 'proxy_manager'

describe ProxyManager::Proxy do
  let(:list) { [['127.0.0.1', 80], ['127.0.0.1', 8080]] }
  let(:proxies_file) { File.join(ProxyManager.root,
                                 'spec',
                                 'support',
                                 'proxies.txt'
                                ) }
  let(:proxy) { ProxyManager::Proxy.new(['127.0.0.1:80', '127.0.0.1:8080']) }

  it 'should return list' do
    expect(proxy.list).to match_array list
  end

  context '#connectable' do
    it 'should response' do
      expect(proxy).to respond_to(:connectable?)
    end

    it 'should receive array' do
      expect(proxy.connectable?(['google.com', 80])).to be_true
    end

    it 'should receive string' do
      expect(proxy.connectable?('google.com:80')).to be_true
    end
  end

  context '#get' do
    it 'should response' do
      expect(proxy).to respond_to(:get)
    end

    it 'should return array' do
      expect(proxy.get).to be_a Array
    end

    it 'should return many proxies' do
      expect { proxy.get(3) }.not_to raise_error
    end
  end

  context 'when load from file' do
    let(:proxy) { ProxyManager::Proxy.new(proxies_file) }

    it 'should return list' do
      expect(proxy.list).to match_array list
    end

    context 'and save file' do
      before { @source = File.read(proxies_file) }

      it 'should update proxies source' do
        proxy.get(2)

        source = ''
        proxy.list.each_with_index do |p, index|
          source << "#{p[0]}:#{p[1]}"
          source << "\n" if proxy.list[index + 1]
        end

        expect(File.open(proxies_file, "rb").read).to eq(source)
      end

      after do
        File.open(proxies_file, 'w').write(@source)
      end
    end
  end
end
