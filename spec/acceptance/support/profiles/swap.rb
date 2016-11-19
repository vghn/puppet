shared_examples 'profile::swap' do
  describe file('/var/swap.space') do
    it { is_expected.to exist }
  end

  describe file('/etc/fstab') do
    its(:content) { is_expected.to match %r{\/var\/swap\.space} }
  end

  describe command('/sbin/swapon -s') do
    its(:stdout) { is_expected.to match %r{\/var\/swap\.space} }
  end
end
