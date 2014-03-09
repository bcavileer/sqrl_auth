require 'spec_helper'
require 'sqrl/enscrypt'

describe SQRL::EnScrypt do
  describe 'iterations', :slow => true do
    it {expect(SQRL::EnScrypt.encode_iterations(nil, nil, 1)).to eq('a8ea62a6e1bfd20e4275011595307aa302645c1801600ef5cd79bf9d884d911c')}
    it {expect(SQRL::EnScrypt.encode_iterations(nil, nil, 100)).to eq('45a42a01709a0012a37b7b6874cf16623543409d19e7740ed96741d2e99aab67')}
    it {expect(SQRL::EnScrypt.encode_iterations(nil, nil, 1000)).to eq('3f671adf47d2b1744b1bf9b50248cc71f2a58e8d2b43c76edb1d2a2c200907f5')}
    it {expect(SQRL::EnScrypt.encode_iterations('password', nil, 123)).to eq('129d96d1e735618517259416a605be7094c2856a53c14ef7d4e4ba8e4ea36aeb')}
    it {expect(SQRL::EnScrypt.encode_iterations('password', "\0"*32, 123)).to eq('2f30b9d4e5c48056177ff90a6cc9da04b648a7e8451dfa60da56c148187f6a7d')}
  end

  describe 'time' do
    subject {SQRL::EnScrypt.encode_time(nil, nil, 1)}
    it {expect(subject[1]).to be > 1}
  end
end
