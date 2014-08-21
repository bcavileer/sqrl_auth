require 'spec_helper'
require 'sqrl/enhash'

describe SQRL::EnHash do
  it {expect(SQRL::EnHash.call('x'.b*32)).to be_kind_of(String)}
  it {expect(SQRL::EnHash.call('x'.b*32).length).to eq(32)}
end
