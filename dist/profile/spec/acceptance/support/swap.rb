shared_examples 'profile::swap' do
  describe file('/var/swap.space') do
    it { should exist }
  end

  describe file('/etc/fstab') do
    its(:content) { should match %r{\/var\/swap\.space} }
  end

  describe command('/sbin/swapon -s') do
    its(:stdout) { should match %r{\/var\/swap\.space} }
  end
end
