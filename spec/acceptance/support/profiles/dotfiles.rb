shared_examples 'profile::dotfiles' do
  describe file('/opt/dotfiles') do
    it { is_expected.to be_directory }
  end
  describe file('/opt/dotfiles/install.sh') do
    it { is_expected.to exist }
    it { is_expected.to be_executable }
  end
end
