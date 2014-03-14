require 'spec_helper'
require 'sqrl/url'

describe SQRL::URL do
  describe 'server' do
    subject {SQRL::URL.new('example.com/sqrl', 'awnuts')}
    it {expect(subject.to_s).to eq('sqrl://example.com/sqrl?nut=awnuts')}
  end

  describe 'client' do
    subject {SQRL::URL.parse('sqrl://example.com/sqrl?nut=awnuts')}
    it {expect(subject.host).to eq('example.com')}
    it {expect(subject.nut).to eq('awnuts')}
  end
end
