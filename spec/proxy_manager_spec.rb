require 'spec_helper'
require 'proxy_manager'

describe ProxyManager do
  it { expect(subject.root).not_to be_empty }
end
