shared_examples 'profile::ruby' do
  describe package('ruby') do
    it { is_expected.to be_installed }
  end
end
