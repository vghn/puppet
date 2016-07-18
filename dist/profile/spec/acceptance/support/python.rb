shared_examples 'profile::python' do
  describe package('pip') do
    it { is_expected.to be_installed }
  end
end
