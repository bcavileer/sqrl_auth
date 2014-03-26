require 'spec_helper'
require 'sqrl/url'

describe SQRL::URL do
  describe 'server' do
    subject {SQRL::URL.new('example.com/sqrl', 'awnuts')}
    it {expect(subject.to_s).to eq('sqrl://example.com/sqrl?nut=awnuts')}
    it {expect(subject.post_path).to eq('https://example.com/sqrl?nut=awnuts')}

    describe 'bar' do
      subject {SQRL::URL.new('example.com/foo|sqrl', 'awnuts')}
      it {expect(subject.to_s).to eq('sqrl://example.com/foo|sqrl?nut=awnuts')}
      it {expect(subject.post_path).to eq('https://example.com/foo/sqrl?nut=awnuts')}
    end
  end

  describe 'client' do
    subject {SQRL::URL.parse('sqrl://example.com/sqrl?nut=awnuts')}
    it {expect(subject.signing_host).to eq('example.com')}
    it {expect(subject.nut).to eq('awnuts')}

    describe 'bar' do
      subject {SQRL::URL.parse('sqrl://example.com/foo|sqrl?nut=awnuts')}
      it {expect(subject.signing_host).to eq('example.com/foo')}
      it {expect(subject.nut).to eq('awnuts')}
    end
  end
end
