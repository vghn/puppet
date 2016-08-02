shared_examples 'profile::vgs' do
  describe file('/opt/vgs/load') do
    it { is_expected.to be_present }
  end
end
