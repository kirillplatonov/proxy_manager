require 'spec_helper'
require 'proxy_manager'

describe ProxyManager::Proxy do
  let(:list) { [['127.0.0.1', 80], ['127.0.0.1', 8080]] }
  let(:proxies_file) { File.join(ProxyManager.root,
                                 'spec',
                                 'support',
                                 'proxies.txt'
                                ) }
  subject { ProxyManager::Proxy.new(['127.0.0.1:80', '127.0.0.1:8080']) }

  context '#get' do
    its(:get) { should be_a Array }

    it 'should return many proxies' do
      expect { subject.get(3) }.not_to raise_error
    end
  end

  context '#get!' do
    it { should respond_to :get! }
  end

  context '#list' do
    its(:list) { should match_array list }
  end

  context '::connectable' do
    it 'should receive array' do
      expect(ProxyManager::Proxy.connectable?(['127.0.0.1', 8080])).to be_false
    end

    it 'should receive string' do
      expect(ProxyManager::Proxy.connectable?("127.0.0.1:8080")).to be_false
    end
  end

  context 'when load from file' do
    subject { ProxyManager::Proxy.new(proxies_file) }

    its(:list) { should match_array list }

    context 'and save file' do
      let(:source) { IO.read(proxies_file) }

      it 'should update proxies source' do
        subject.get(2)

        source = ''
        subject.list.each { |p| source << "#{p[0]}:#{p[1]}\n" }
        source.sub!(/\n$/, '')

        expect(IO.read(proxies_file)).to eq(source)
      end

      after { IO.write(proxies_file, source) }
    end
  end
end
