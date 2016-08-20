shared_examples 'profile::aws::efs' do
  describe file('/etc/fstab') do
    its(:content) { is_expected.to match(/fs-1234/) }
  end

  describe command('mountpoint -q /efs') do
    its(:exit_status) { is_expected.to eq 0 }
  end
end
