shared_examples 'profile::jq' do
  describe file('/usr/local/bin/jq') do
    it { is_expected.to be_executable }
  end
end
