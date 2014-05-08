require 'spec_helper'
require 'proxy_manager'

describe ProxyManager::Proxy do
  let(:list) { [['0.0.1.0', 9000], ['0.0.0.1', 2000], ['0.0.0.0', 7000]] }
  let(:proxies_file) { File.join(ProxyManager.root, 'spec', 'support', 'proxies.txt') }
  let(:bad_proxies_file) { File.join(ProxyManager.root, 'spec', 'support', 'bad_proxies.txt') }
  let(:proxy) { ProxyManager::Proxy.new(['0.0.1.0:9000', '0.0.0.1:2000', '0.0.0.0:7000']) }

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

  it { expect(proxy.bad_list).to be_a Array }

  context 'when load from file' do
    let(:proxy) { ProxyManager::Proxy.new(proxies_file, bad_proxies_file) }

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
        File.open(bad_proxies_file, 'w').truncate(0)
      end
    end
  end
end
